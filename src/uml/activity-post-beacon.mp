input metauml;

vardef draw_points(suffix width, height)(text systems) =
    i := 0;
    for system=systems:
        pair A[];
        A[0] := (i * width, 0);
        A[1] := ((i + 1) * width, 0);
        A[2] := ((i + 1) * width, height);
        A[3] := (i * width, height);
        draw A[0]--A[1]--A[2]--A[3]--cycle;

        % string tag; tag := str system;
        pair label_pos; label_pos := ((i + 0.5) * width, height - 5);
        label(system, label_pos);

        i := i + 1;
    endfor;
enddef;

beginfig(1);
iActivity.foreColor := (1.0, 1.0, 1.0);
iState.foreColor := (1.0, 1.0, 1.0);

width := 100;
height := 300;
state_gap := 20;
draw_points(width, height)("User", "Frontend", "Backend");

Begin.begin;
begin.n = (width / 2, height - 30);
State.Open("Open Camera", " View")();
State.TakePicture("Take Picture")();
State.EnterDescription("Enter Description")();
topToBottom(state_gap)(begin, Open, TakePicture, EnterDescription);
drawObjects(begin, Open, TakePicture, EnterDescription);
link(transition)(begin.s -- Open.n);
link(transition)(Open.s -- TakePicture.n);
link(transition)(TakePicture.s -- EnterDescription.n);

State.TakeGeotag("Take Geotag")();
State.SubmitBeacon("Submit Beacon", "")();
TakeGeotag.n = (1.5 * width, ypart EnterDescription.n);
topToBottom(state_gap)(SubmitBeacon, TakeGeotag);
drawObjects(TakeGeotag, SubmitBeacon);
link(transition)(EnterDescription.e -- TakeGeotag.w);
link(transition)(TakeGeotag.n -- SubmitBeacon.s);

State.AddToDatabase("Add To Database", "")();
State.ReturnSuccess("Return 200 OK", "")();
AddToDatabase.n = (2.5 * width, ypart SubmitBeacon.n);
topToBottom(70)(AddToDatabase, ReturnSuccess);
drawObjects(AddToDatabase, ReturnSuccess);
link(transition)(SubmitBeacon.e -- AddToDatabase.w);
link(transition)(AddToDatabase.s -- ReturnSuccess.n);

State.DisplayComments("Display New", "Comment Thread")();
DisplayComments.n = (1.5 * width, ypart ReturnSuccess.n);
drawObject(DisplayComments);
link(transition)(ReturnSuccess.w -- DisplayComments.e);

End.endState;
endState.w = (0.5 * width, ypart DisplayComments.w);
drawObject(endState);
link(transition)(DisplayComments.w -- endState.e);

endfig;
end
