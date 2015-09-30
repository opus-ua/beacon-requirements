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
height := 350;
state_gap := 20;
draw_points(width, height)("User", "Frontend", "Backend");

Begin.begin;
begin.n = (width / 2, height - 30);
State.Open("Heart Post", "")();
topToBottom(state_gap)(begin, Open);
drawObjects(begin, Open);
link(transition)(begin.s -- Open.n);

State.TakeGeotag("Check If", "Valid")();
Branch.Valid;
State.SubmitRequest("Submit Request", "")();
TakeGeotag.n = (1.5 * width, ypart Open.n);
topToBottom(state_gap)(TakeGeotag, Valid, SubmitRequest);
drawObjects(TakeGeotag, Valid, SubmitRequest);
link(transition)(Open.e -- TakeGeotag.w);
link(transition)(TakeGeotag.s -- Valid.n);
link(transition)(Valid.s -- SubmitRequest.n);
item(iStereo)("[valid]")(obj.w = 0.4[Valid.s,SubmitRequest.n]);

End.FirstPrematureEnd;
FirstPrematureEnd.w = (xpart begin.w, ypart Valid.w);
drawObject(FirstPrematureEnd);
link(transition)(Valid.w -- FirstPrematureEnd.e);
item(iStereo)("[invalid]")(obj.n = 0.25[Valid.w,FirstPrematureEnd.e]);

State.AddToDatabase("Check If", "Valid")();
Branch.ReturnSuccess;
State.HeartPost("Heart Post")();
State.Return("Return Success")();
AddToDatabase.n = (2.5 * width, ypart SubmitRequest.n);
topToBottom(state_gap)(AddToDatabase, ReturnSuccess, HeartPost, Return);
drawObjects(AddToDatabase, ReturnSuccess, HeartPost, Return);
link(transition)(SubmitRequest.e -- AddToDatabase.w);
link(transition)(AddToDatabase.s -- ReturnSuccess.n);
link(transition)(ReturnSuccess.s -- HeartPost.n);
link(transition)(HeartPost.s -- Return.n);
item(iStereo)("[valid]")(obj.w = 0.4[ReturnSuccess.s, HeartPost.n]);

End.SecondPrematureEnd;
SecondPrematureEnd.w = (xpart begin.w, ypart ReturnSuccess.w);
drawObject(SecondPrematureEnd);
link(transition)(ReturnSuccess.w -- SecondPrematureEnd.e);
item(iStereo)("[invalid]")(obj.n = 0.5[ReturnSuccess.w, SecondPrematureEnd.e]);

State.DisplayComments("Fill Heart")();
DisplayComments.n = (1.5 * width, ypart Return.n);
drawObject(DisplayComments);
link(transition)(Return.w -- DisplayComments.e);

End.endState;
endState.w = (xpart begin.w, ypart DisplayComments.w);
drawObject(endState);
link(transition)(DisplayComments.w -- endState.e);

endfig;
end
