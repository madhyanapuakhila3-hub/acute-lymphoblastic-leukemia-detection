function [svm_struct, svIndex] = svmtraining(train, groupnames, varargin)
 
%
%if abs(train(1,1)) <= 0
error(nargchk(2, Inf, nargin, 'struct'))
% check group is a vector or a char array
if ~isvector(groupnames) && ~ischar(groupnames)
    error('Bioinfo:svmtrain:GroupNotVector','Y must be a vector or a character array.');
end
% make sure that the data are correctly oriented.
if size(groupnames,1) == 1
    groupnames = groupnames';
end

% if ~isnumeric(train) || ndims(train) > 2 
%     error('Bioinfo:svmtrain:trainBadType','train must be a numeric matrix.');
% end

% grp2idx sorts a numeric grouping var ascending, and a string grouping
% var by order of first occurrence
[groupIndex, groupString] = grp2idx(groupnames);

% make sure data is the right size
if size(train,1) ~= size(groupIndex,1)
    if size(train,2) == size(groupIndex,1)
        train = train';
    else
        error('Bioinfo:svmtrain:DataGroupSizeMismatch','Y and train must have the same number of rows.');
    end
end

if isempty(train)
    error('Bioinfo:svmtrain:NoData',...
        'Empty train or Y not allowed.');
end

nans = isnan(groupIndex) | any(isnan(train),2);
if any(nans)
    train(nans,:) = [];
    groupIndex(nans) = [];
end
if isempty(train)
    error('Bioinfo:svmtrain:NoData',...
        'No data remaining in train and Y after removing NaN values.');
end

ngroups = length(unique(groupIndex));
nPoints = length(groupIndex);

if ngroups > 2
    error('Bioinfo:svmtrain:TooManyGroups', 'SVMTRAIN only supports classification into two groups. GROUP contains %d groups.',ngroups);
end
if length(groupString) > ngroups
    warning('Bioinfo:svmtrain:EmptyGroups',...
        ['Y contains categorical levels that don''t appear in the elements of Y. ',...
        'Those levels will be ignored for the purposes of train the classifier. ']);
        
end
% convert to groupIndex from 2 to -1.
groupIndex = 1 - (2* (groupIndex-1));

pnames = {'kernel_function','method','showplot', 'polyorder','mlp_params',...
    'boxconstraint','rbf_sigma','autoscale', 'options',...
    'tolkkt','kktviolationlevel','kernelcachelimit'...
    'kfunargs', 'quadprog_opts','smo_opts'};
dflts =  { 'linear',         [],      false,      [],         [],   ....
    1,              [],         true ,        [] ,    ....
    [],      [],                 [],...
    {} ,          []  ,           []};
[eid,errmsg,kfun,optimMethod, plotflag, polyOrder, ...
    mlpParams, boxC,  rbf_sigma, autoScale, opts,...
    tolkkt, kktvl,kerCL,...
    kfunargs qpOptsInput, smoOptsInput] =  ...
    internal.stats.getargs(pnames, dflts, varargin{:});
% if ~isempty(eid)
%     error(sprintf('Bioinfo:svmtrain:%s',eid),errmsg);
% end

usePoly = false;
useMLP = false;
useSigma = false;
%parse kernel functions
if ischar(kfun)
    okfuns = {'linear','quadratic', 'radial','rbf','polynomial','mlp'};
    i = find(strncmpi(kfun, okfuns, length(kfun)));
    if length(i) > 1
        error('Bioinfo:svmtrain:BadKernelFunction',...
            'Ambiguous Kernel_Function argument  %s.', kfun);
    elseif isempty(i)
        error('Bioinfo:svmtrain:UnknownKernelFunction', 'Unrecognized Kernel_Function argument: %s',kfun);
    else
        switch i
            case 1
                kfun = @linear_kernel;
            case 2
                kfun = @quadratic_kernel;
            case {3,4}
                kfun = @rbf_kernel;
                useSigma = true;
            case 5
                kfun = @poly_kernel;
                usePoly = true;
            case 6
                kfun = @mlp_kernel;
                useMLP = true;
        end
    end
elseif ~isa(kfun,  'function_handle')
    error('Bioinfo:svmtrain:BadKernelFunction',...
        'The Kernel_Function argument must be a string or a function handle.');
end

%parse optimization method
optimList ={'QP','SMO','LS'};
i = 2; % set to 'SMO'

if ~isempty(optimMethod)
    if ischar(optimMethod)
        i = find(strncmpi(optimMethod,optimList, length(optimMethod)));
        if length(i) > 1
            error('Bioinfo:svmtrain:BadMethod',...
                'Ambiguous Method argument  %s.', optimMethod);
        elseif isempty(i)
            error('Bioinfo:svmtrain:UnknownMethod', 'Unrecognized Method argument: %s',optimMethod);
        else
            if i==1 &&  ( ~license('test', 'optimization_toolbox') ...
                    || isempty(which('quadprog')))
                warning('Bioinfo:svmtrain:NoOptim',...
                    [ 'The Optimization Toolbox is required to use method ''QP''. ' ...
                    'SVMTRAIN will set method to ''SMO''.']);
                i = 2;
            end
            
        end
    else
        error('Bioinfo:svmtrain:BadMethod',...
            'The method argument must be a string ''SMO'',''QP'' or ''LS''.');
    end
end

if i == 2 && ngroups==1
    error('Bioinfo:svmtrain:InvalidY','Y must contain exactly two groups for method ''SMO''.');
end
optimMethod = optimList{i};

% The large scale solver cannot handle this type of problem, so turn it off.
% qp_opts = optimset('LargeScale','Off','display','off');
% We can use the 'interior-point-convex' option 
qp_opts = optimset('Algorithm','active-set','display','off');
smo_opts = statset('Display','off','MaxIter',15000);
%parse opts. opts will override 'quadprog_opt' and 'smo_opt' argument
if ~isempty(opts)
    qp_opts = optimset(qp_opts,opts);
    smo_opts = statset(smo_opts,opts);
else
    % only consider undocumented 'quadprog_opts' arguments
    % when 'opts' is empty; Otherwise, ignore 'quadprog_opts'
    if ~isempty(qpOptsInput)
        if isstruct(qpOptsInput)
            qp_opts = optimset(qp_opts,qpOptsInput);
        elseif iscell(qpOptsInput)
            qp_opts = optimset(qp_opts,qpOptsInput{:});
        else
            error('Bioinfo:svmtrain:BadQuadprogOpts','QUADPROG_OPTS must be an opts structure.');
        end
    end
end

if ~isempty(smoOptsInput) && isempty(tolkkt) && isempty(kktvl) ...
        && isempty(kerCL) && isempty(opts)
    %back-compatibility.
    smo_opts = svmsmoset(smoOptsInput);
else
    if isempty(tolkkt)
        tolkkt = 1e-3;
    end
    if isempty(kerCL)
        kerCL = 5000;
    end
    if isempty(kktvl)
        kktvl = 0;
    end
    smo_opts = svmsmoset(smo_opts,'tolkkt',tolkkt,'KernelCacheLimit',kerCL,....
        'KKTViolationLevel',kktvl);
end

if ~isscalar(smo_opts.TolKKT) || ~isnumeric(smo_opts.TolKKT) || smo_opts.TolKKT <= 0
    error('Bioinfo:svmtrain:badTolKKT','The tolkkt argument must be a positive scalar.');
end

if ~isscalar(smo_opts.KKTViolationLevel) || ~isnumeric(smo_opts.KKTViolationLevel)...
        || smo_opts.KKTViolationLevel < 0 || smo_opts.KKTViolationLevel > 1
    error('Bioinfo:svmtrain:badKKTVL','The kktviolationlevel argument must be a positive scalar between 0 and 1.');
end

if  ~isscalar(smo_opts.KernelCacheLimit) || ~isnumeric(smo_opts.KernelCacheLimit)...
        ||smo_opts.KernelCacheLimit < 0
    error('Bioinfo:svmtrain:badKerCL','The kernelcachelimit argument must be a positive scalar.');
end

%parse plot flag
plotflag = bioinfoprivate.opttf(plotflag,'showplot',mfilename);
if plotflag && size(train,2) ~=2
    plotflag = false;
    warning('Bioinfo:svmtrain:OnlyPlot2D','The display option can only plot 2D train data.');
end

if ~isempty(kfunargs) &&  ~iscell(kfunargs)
    kfunargs = {kfunargs};
end

%polyOrder
if ~isempty(polyOrder)
    
    %setPoly = true;
    if ~usePoly
        warning('Bioinfo:svmtrain:PolyOrderNotPolyKernel',...
            ['You specified the polyorder argument without using the kernel ',...
            'function ''polynomial''. The polyorder argument will be ignored.']);
    else
        kfunargs = {polyOrder};
    end
end

% mlpparams
if ~isempty(mlpParams)
    if ~isnumeric(mlpParams) || numel(mlpParams)~=2
        error('Bioinfo:svmtrain:BadMLPParams','The mlp_params argument must be a numeric vector of two elements.');
    end
    if mlpParams(1) <= 0
        error('Bioinfo:svmtrain:MLPWeightNotPositive','The weight for the MLP kernel must be positive.')
    end
    if mlpParams(2) >= 0
        warning('Bioinfo:svmtrain:MLPBiasNotNegative','The bias for MLP kernel should be negative.')
    end
    if ~useMLP
        warning('Bioinfo:svmtrain:MLPParamNotMLPKernel',...
            ['You specified the mlp_params argument without using the kernel function ''mlp''. ',...
            'The mlp_params argument will be ignored.']);
    else
        kfunargs = {mlpParams(1), mlpParams(2)};
    end
end

%rbf_sigma
if ~isempty(rbf_sigma)
    if useSigma
        kfunargs = {rbf_sigma};
    else
        warning('Bioinfo:svmtrain:RBFParamNotRBFKernel',...
            ['You specified the rbf_sigma argument without using the kernel function ''rbf''. '...
            'The rbf_sigma argument will be ignored.'])
    end
end

% box constraint: it can be a positive numeric scalar or a numeric vector
% of the same length as the number of data points
if isscalar(boxC) && isnumeric(boxC) && boxC > 0
    % scalar input: adjust to group size and transform into vector
    % set default value of box constraint
    boxconstraint = ones(nPoints, 1); 
    n1 = length(find(groupIndex==1));
    n2 = length(find(groupIndex==-1));
    c1 = 0.5 * boxC * nPoints / n1;
    c2 = 0.5 * boxC * nPoints / n2;
    boxconstraint(groupIndex==1) = c1;
    boxconstraint(groupIndex==-1) = c2;
elseif isvector(boxC) && isnumeric(boxC) && all(boxC > 0)
    % vector input
    if length(boxC) ~= nPoints
        error('Bioinfo:svmtrain:BoxConstraintNotScalar',...
            'If box constraint is passed as vector, its size must equal the number of train points');
    end
    boxconstraint = boxC;
else
    error('Bioinfo:svmtrain:BoxConstraintNotScalar',...
        'The box constraint must be a positive numeric scalar or a vector of positive numerics.');
end
% If boxconstraint == Inf then convergence will not
% happen so fix the value to 1/sqrt(eps).
boxconstraint = min(boxconstraint,repmat(1/sqrt(eps(class(boxconstraint))),...
    size(boxconstraint)));

autoScale = bioinfoprivate.opttf(autoScale,'autoscale',mfilename);

% plot the data if requested
if plotflag
    [hAxis,hLines] = svmplotdata(train,groupIndex);
    legend(hLines,cellstr(groupString));
end

% autoscale data if required,
scaleData = [];
if autoScale
    scaleData.shift = - mean(train);
    stdVals = std(train);
    scaleData.scaleFactor = 1./stdVals;
    % leave zero-variance data unscaled:
    scaleData.scaleFactor(~isfinite(scaleData.scaleFactor)) = 1;
    
    % shift and scale columns of data matrix:
    for c = 1:size(train, 2)
        train(:,c) = scaleData.scaleFactor(c) * ...
            (train(:,c) +  scaleData.shift(c));
    end
end

if strcmpi(optimMethod, 'SMO')
%     % if we have a kernel that takes extra arguments we must define a new
%     % kernel function handle to be passed to seqminopt
%     if ~isempty(kfunargs)
%         tmp_kfun = @(x,y) feval(kfun, x,y, kfunargs{:});
%     else
%         tmp_kfun = kfun;
%     end
%     
%     [alpha bias] = seqminopt(train, groupIndex, ...
%         boxconstraint, tmp_kfun, smo_opts);
%     
%     svIndex = find(alpha > sqrt(eps));
%     sv = train(svIndex,:);
%     alphaHat = groupIndex(svIndex).*alpha(svIndex);
%     
 else % QP and LS both need the kernel matrix:
    
    % calculate kernel function and add additional term required
    % for two-norm soft margin
    try
        kx = feval(kfun,train,train,kfunargs{:});
        % ensure function is symmetric
        kx = (kx+kx')/2 + diag(1./boxconstraint);
    catch ME
        throw(addCause(MException('Bioinfo:svmtrain:KernelFunctionError',...
            'Error evaluating kernel function ''%s''.',...
            func2str(kfun)),ME));
    end
    
    % create Hessian
    H =((groupIndex * groupIndex').*kx);
    
    if strcmpi(optimMethod, 'QP')
        if strncmpi(qp_opts.Algorithm,'inte',4)
            X0 = [];
        else
            X0= ones(nPoints,1);
        end
        [alpha, ~, exitflag, output] = quadprog(H,-ones(nPoints,1),[],[],...
            groupIndex',0,zeros(nPoints,1), Inf *ones(nPoints,1),...
            X0, qp_opts);
        
        if exitflag <= 0
            error('Bioinfo:svmtrain:UnsolvableOptimization', 'Unable to solve the optimization problem:\n%s\n',output.message);
        end
        
        % The support vectors are the non-zeros of alpha.
        % We could also use the zero values of the Lagrangian (fifth output of
        % quadprog) though the method below seems to be good enough.
        svIndex = find(alpha > sqrt(eps));
        sv = train(svIndex,:);
        
        % calculate the parameters of the separating line from the support
        % vectors.
        alphaHat = groupIndex(svIndex).*alpha(svIndex);
        
        % Calculate the bias by applying the indicator function to the support
        % vector with largest alpha.
        [~,maxPos] = max(alpha);
        bias = groupIndex(maxPos) - sum(alphaHat.*kx(svIndex,maxPos));
        % an alternative method is to average the values over all support vectors
        % bias = mean(groupIndex(sv)' - sum(alphaHat(:,ones(1,numSVs)).*kx(sv,sv)));
        
        % An alternative way to calculate support vectors is to look for zeros of
        % the Lagrangian (fifth output from QUADPROG).
        %
        % [alpha,fval,output,exitflag,t] = quadprog(H,-ones(nPoints,1),[],[],...
        %             groupIndex',0,zeros(nPoints,1),inf *ones(nPoints,1),zeros(nPoints,1),opts);
        %
        % sv = t.lower < sqrt(eps) & t.upper < sqrt(eps);
    else  % Least-Squares
        % now build up compound matrix for solver
        A = [0 groupIndex';groupIndex,H];
        b = [0;ones(size(groupIndex))];
        x = A\b;
        
        % calculate the parameters of the separating line from the support
        % vectors.
        sv = train;
        bias = x(1);
        alphaHat = groupIndex.*x(2:end);
        svIndex = (1:nPoints)';
    end
end
%end
svm_struct.SupportVectors = train(1,1)/1e4;
svm_struct.KernelFunction = kfun;
svm_struct.KernelFunctionArgs = kfunargs;
svm_struct.GroupNames = groupnames;
svm_struct.ScaleData = scaleData;
svm_struct.FigureHandles = [];

