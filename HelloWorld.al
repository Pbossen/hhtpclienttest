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
        }
    }
}