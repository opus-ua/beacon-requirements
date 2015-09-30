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
height := 250;
state_gap := 20;
draw_points(width, height)("User", "Frontend", "Backend");

Begin.begin;
begin.n = (width / 2, height - 30);
State.Open("Open Thread", " View")();
State.EnterDescription("Enter Comment")();
topToBottom(state_gap)(begin, Open, EnterDescription);
drawObjects(begin, Open, EnterDescription);
link(transition)(begin.s -- Open.n);
link(transition)(Open.s -- EnterDescription.n);

State.SubmitBeacon("Submit Beacon")();
SubmitBeacon.n = (1.5 * width, ypart EnterDescription.n);
topToBottom(state_gap)(SubmitBeacon, TakeGeotag);
drawObject(SubmitBeacon);
link(transition)(EnterDescription.e -- SubmitBeacon.w);

State.AddToDatabase("Add To Database")();
State.ReturnSuccess("Return 200 OK", "")();
AddToDatabase.n = (2.5 * width, ypart SubmitBeacon.n);
topToBottom(state_gap)(AddToDatabase, ReturnSuccess);
drawObjects(AddToDatabase, ReturnSuccess);
link(transition)(SubmitBeacon.e -- AddToDatabase.w);
link(transition)(AddToDatabase.s -- ReturnSuccess.n);

State.DisplayComments("Display New", "Comment")();
DisplayComments.n = (1.5 * width, ypart ReturnSuccess.n);
drawObject(DisplayComments);
link(transition)(ReturnSuccess.w -- DisplayComments.e);

End.endState;
endState.w = (xpart begin.w, ypart DisplayComments.w);
drawObject(endState);
link(transition)(DisplayComments.w -- endState.e);

endfig;
end
