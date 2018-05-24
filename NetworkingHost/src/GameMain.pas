program GameMain;
uses SwinGame, sgTypes;

const PORT = 4000;

function WaitForConnections() : Connection;
begin
    result := nil;
    while result = nil do
    begin
        AcceptTCPConnection();
        result := FetchConnection();
    end;

    WriteLn('Connection made');
end;

procedure Main();
var
    conn : Connection;
begin
    OpenGraphicsWindow('Host', 800, 600);
 
    ClearScreen(ColorWhite);
    // Create host
    if CreateTCPHost(PORT) then
        DrawText('yo we good', ColorBlack, 10, 10)
    else
        DrawText('yo dawg something fucked', ColorBlack, 10, 10);

    conn := WaitForConnections();
    
    repeat // The game loop...
        ProcessEvents();
    
        if KeyTyped(KeyCode(32)) then
            SendTCPMessage('SPACE', conn);

        RefreshScreen(60);
    until WindowCloseRequested();
end;

begin
    Main();
end.
