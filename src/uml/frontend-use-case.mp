input metauml;
beginfig(1);
    iUsecase.foreColor := (1.0, 1.0, 1.0);

    Usecase.CreateAccount("Create Account");
    Usecase.PostBeacon("Post Beacon");
    Usecase.ViewMap("View Map");
    Usecase.ViewCommentThread("View Comment Thread");
    Usecase.HeartBeacon("Heart Beacon");
    Usecase.PostComment("Post Comment");
    Usecase.ViewUserProfile("View User Profile");
    Usecase.Flag("Flag Post");

    topToBottom(6)(CreateAccount,
                    PostBeacon,
                    ViewMap,
                    ViewCommentThread,
                    HeartBeacon,
                    PostComment,
                    ViewUserProfile,
                    Flag);

    Group.Cases(CreateAccount, 
            PostBeacon,
            ViewMap,
            ViewCommentThread,
            HeartBeacon,
            PostComment,
            ViewUserProfile,
            Flag);
    
    top_space := 25;
    Cases.nw = (125, -1 * top_space);
    drawObject(Cases);

    pair A[];
    margin := 2;
    A[0] := (xpart Cases.w - margin, 0);
    A[1] := (xpart Cases.e + margin, 0);
    A[2] := (xpart Cases.e + margin, (ypart Cases.s) - 4);
    A[3] := (xpart Cases.w - margin, (ypart Cases.s) - 4);

    Actor.User("User");
    User.e = (0, ypart Cases.w);
    drawObject(User);

    Actor.Backend("Backend");
    Backend.w = (xpart Cases.e + xpart (Cases.w - User.e), ypart Cases.e);
    drawObject(Backend); 

    link(association)(User.e -- CreateAccount.w);
    link(association)(User.e -- PostBeacon.w);
    link(association)(User.e -- ViewMap.w);
    link(association)(User.e -- ViewCommentThread.w);
    link(association)(User.e -- HeartBeacon.w);
    link(association)(User.e -- PostComment.w);
    link(association)(User.e -- ViewUserProfile.w);
    link(association)(User.e -- Flag.w);

    link(association)(Backend.w -- CreateAccount.e);
    link(association)(Backend.w -- PostBeacon.e);
    link(association)(Backend.w -- ViewMap.e);
    link(association)(Backend.w -- ViewCommentThread.e);
    link(association)(Backend.w -- HeartBeacon.e);
    link(association)(Backend.w -- PostComment.e);
    link(association)(Backend.w -- ViewUserProfile.e);
    link(association)(Backend.w -- Flag.e);

    draw A[0]--A[1]--A[2]--A[3]--cycle;
    label("Android Frontend", (xpart Cases.n, (-top_space / 3.0)))
    
    endfig;
end

