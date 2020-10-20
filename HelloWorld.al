// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 60100 ItemCardExt extends "Item Card"
{
    actions
    {
        addfirst(Functions)
        {
            action("Download Picture")
            {
                Image = Picture;
                ApplicationArea = all;
                Caption = 'Download Picture';

                trigger OnAction()
                var
                    Httpclient: HttpClient;
                    HttpResponse: HttpResponseMessage;
                    HttpContent: HttpContent;
                    Instream: InStream;
                    UrlText: Text;

                begin
                    UrlText := 'https://www.eurotoys.dk/pic/produkter-sized/80-020797_680.jpg';
                    IF Httpclient.Get(UrlText, HttpResponse) then begin
                        if HttpResponse.HttpStatusCode = 200 then begin
                            if HttpResponse.Content.ReadAs(Instream) then begin
                                rec.Picture.ImportStream(Instream, '');
                                Rec.Modify();
                            end;
                        end else
                            Error('Øv');
                    end;

                end;
            }
            action("Get floatrate Curr Rates")
            {
                ApplicationArea = all;
                image = ImportCodes;

                trigger OnAction()
                var
                    Httpclient: HttpClient;
                    HttpResponse: HttpResponseMessage;
                    HttpContent: HttpContent;
                    Instream: InStream;
                    UrlText: Text;
                    JSonText: Text;
                    JsonObject: JsonObject;
                    JsonToken: JsonToken;
                    Jsonarray: JsonArray;
                Begin
                    UrlText := 'http://www.floatrates.com/daily/dkk.json';
                    IF Httpclient.Get(UrlText, HttpResponse) then begin
                        if HttpResponse.HttpStatusCode = 200 then begin
                            HttpResponse.Content.ReadAs(JSonText);
                            JSonText := '[' + JSonText + ']';
                            Jsonarray.ReadFrom(JSonText);
                            foreach jsontoken in Jsonarray do begin
                                JsonObject := JsonToken.AsObject();
                                Error('%1', JsonObject);
                            end;


                            //Error('%1',JsonToken);

                        end else
                            Error('Øv');
                    end;


                end;
            }
        }
    }
}