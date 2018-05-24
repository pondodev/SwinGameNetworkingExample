program GameMain;
uses SwinGame, sgTypes;

const
    PORT = 4000;
    CONN : Connection = nil;

function WaitToConnectToHost() : Connection;
var
    i : Integer;
begin
    i := 0;
    result := nil;
    while result = nil do
    begin
        i += 1;
        result := CreateTCPConnection('127.0.0.1', PORT);
    end;
    WriteLn('Connection made');
end;

procedure Main();
var
    toggled : Boolean;
    bgColor : Color;
begin
    OpenGraphicsWindow('Client', 800, 600);

    CONN := WaitToConnectToHost();

    repeat // The game loop...
        ProcessEvents();

        if TCPMessageReceived() then
        begin
            if ReadMessage(CONN) = 'SPACE' then
            begin
                WriteLn('SPACE pressed on host');
                if toggled then
                begin
                    toggled := false;
                    bgColor := ColorLightPink;
                end
                else
                begin
                    toggled := true;
                   bgColor := ColorLightBlue;
               end;
            end;
        end;
    
        ClearScreen(bgColor);
    
        RefreshScreen(60);
    until WindowCloseRequested();
end;

begin
    Main();
end.
