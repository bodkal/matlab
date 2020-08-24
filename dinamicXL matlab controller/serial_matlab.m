function [data] = serialread_matlab(port,status,s)
switch status
    case 1

        try
            s = serial(port);
            fopen(s);
            disp("serial "+port+" is open");
            data=s;
        catch
             disp("error connect to "+port);
             data=[];
        end
    case 0
            flushinput(s);
            while(s.BytesAvailable>16)
            continue
            end
            fgetl(s);
            data=split(fgetl(s),":");
            data=data(1);

    case -1
        try
            fclose(s);
            delete(s);
            disp("serial "+port+" is close")
        catch
            disp("error close the port "+port);
        end
end