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
height := 225;
state_gap := 20;
draw_points(width, height)("User", "Frontend", "Backend");

Begin.begin;
begin.n = (width / 2, height - 30);
State.OpenApp("Open Profile", " View")();
topToBottom(state_gap)(begin, OpenApp);
drawObjects(begin, OpenApp);
link(transition)(begin.s -- OpenApp.n);

State.RequestBeacons("Request User", "Info")();
RequestBeacons.n = (1.5 * width, ypart OpenApp.n);
drawObject(RequestBeacons);
link(transition)(OpenApp.e -- RequestBeacons.w);

State.PollDatabase("Poll Database", "for User")();
State.PollForComments("Poll Database", "for Posts")();
State.ReturnBeacons("Return Data")();
PollDatabase.n = (2.5 * width, ypart RequestBeacons.n);
topToBottom(state_gap)(PollDatabase, PollForComments, ReturnBeacons);
drawObjects(PollDatabase, PollForComments, ReturnBeacons);
link(transition)(RequestBeacons.e -- PollDatabase.w);
link(transition)(PollDatabase.s -- PollForComments.n);
link(transition)(PollForComments.s -- ReturnBeacons.n);

State.DisplayBeacons("Display List")();
DisplayBeacons.n = (1.5 * width, ypart ReturnBeacons.n);
drawObject(DisplayBeacons);
link(transition)(ReturnBeacons.w -- DisplayBeacons.e);

End.endState;
endState.w = (0.5 * width, ypart DisplayBeacons.w);
drawObject(endState);
link(transition)(DisplayBeacons.w -- endState.e);

endfig;
end
