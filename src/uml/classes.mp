input metauml;
    beginfig(1);
    
    iClass.foreColor := (1.0, 1.0, 1.0);

    Class.Post("Beacon")
            ("+ID: PostID",
            "+Image: Image",
            "+Popularity: Integer [1-100]",
            "+Location: Geotag",
            "+Poster ID: Integer",
            "+Description: String",
            "+Hearted: Boolean",
            "+Flagged: Boolean")
            ("+SetPopularity(Integer)",
            "+Heart(AppUser)",
            "+Unheart(AppUser)",
            "+Flag(AppUser)");

    Class.Profile("User Profile")
            ("+User: User",
            "+Posts: Integer[]",
            "+Comments: Integer[]")
            ("+Follow(AppUser)",
            "+Unfollow(AppUser)");

    Class.RestClient("REST Client")
            ()
            ("+GetBeaconsByLocation(Geotag, AppUser): BeaconThumbnail[]",
            "+GetThread(PostID, AppUser): Thread",
            "+PostBeacon(Image, Description, Geotag, AppUser)",
            "+PostComment(PostID, String, AppUser)",
            "+Heart(PostID, AppUser)",
            "+Unheart(PostID, AppUser)",
            "+FollowUser(UserID, AppUser)",
            "+UnfollowUser(UserID, AppUser)",
            "+Flag(Reason, PostID, AppUser)");

    align(left, top, bottom)(5)("-")
            (Post,
            Profile,
            RestClient);

    Class.Thread("Thread")
            ("+Post: BeaconPost",
            "+Comments: Comment[]")
            ("+AddComment(String, CommentID, AppUser)");

    Thread.nw = (xpart RestClient.e + 5, 0);

    Class.MapManager("MapManager")
            ("-Beacons: BeaconThumbnail[]",
            "-AppUser: AppUser")
            ("+Refresh()",
            "-OrderBeacons()");

    Class.User("User")
            ("+Username: String",
            "+ID: Integer")
            ();

    Class.AppUser("AppUser")
            ("+User: User",
            "+AuthenticationInfo: Authentication")
            ();

    Class.Comment("Comment")
            ("+Comment: String",
            "+Poster: ID",
            "+ID: ID",
            "+Hearted: Boolean",
            "+Flagged: Boolean")
            ("+Heart(AppUser)",
            "+Unheart(AppUser)",
            "+Flag(Reason, AppUser)");
    
    align(right, top, bottom)(5)("-")
            (Thread,
            MapManager,
            User,
            AppUser,
            Comment);

    drawObjects(Post,
                Profile,
                RestClient,
                Thread,
                MapManager,
                User,
                AppUser,
                Comment);

    endfig;
end;
