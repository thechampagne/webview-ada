with Interfaces.C;	
with Interfaces.C.Strings;

package body Webview is	

   procedure Handle_Error(err: Webview.Raw.Error) is
   begin
   	case err is
   		when Webview.Raw.Error_Missing_Dependency => raise Webview_Error with "Missing Dependency";
		when Webview.Raw.Error_Canceled => raise Webview_Error with "Canceled";	       
		when Webview.Raw.Error_Invalid_State => raise Webview_Error with "Invalid State";	
		when Webview.Raw.Error_Invalid_Argument => raise Webview_Error with "Invalid Argument";	
		when Webview.Raw.Error_Unspecified => raise Webview_Error with "Unspecified";		
		when Webview.Raw.Error_Duplicate => raise Webview_Error with "Duplicate";		
		when Webview.Raw.Error_Not_Found => raise Webview_Error with "Not Found";		
		when others => null;
   	end case;
   end Handle_Error;	
       
   function Boolean_To_C_Int (b : boolean) return Interfaces.C.int is	
   begin
    if B then
        return 1;
    else
        return 0;
    end if;
    end Boolean_To_C_Int;

   function Create (debug : Boolean := False; window : System.Address := System.Null_Address) return Webview_Type is	
   	w : Webview_Type := Webview.Raw.Create(Boolean_To_C_Int(debug), Window);
   begin  	
	return w;
   end Create;

   procedure Destroy (w : Webview_Type) is
	err : Webview.Raw.Error := Webview.Raw.Destroy(w);
   begin
   	Handle_Error(err);
   end Destroy;

   procedure Run (w : Webview_Type) is
   	err : Webview.Raw.Error := Webview.Raw.Run(w);
   begin
	Handle_Error(err);
   end Run;


   procedure Terminate_It (w : Webview_Type) is
   	err : Webview.Raw.Error := Webview.Raw.Terminate_It(w);
   begin
   	Handle_Error(err);
   end Terminate_It;
 

   -- function Dispatch
   --   (w : Webview_Type;
   --    fn : access procedure (w : Webview_Type; arg : System.Address);
   --    arg : System.Address) return Error
 

   function Get_Window (w : Webview_Type) return System.Address is
   begin
    return Webview.Raw.Get_Window(w);
   end Get_Window;
 

   function Get_Native_Handle (w : Webview_Type; kind : Native_Handle_Kind) return System.Address is	
   begin    
    return Webview.Raw.Get_Native_Handle(w, kind);
   end Get_Native_Handle;
 

   procedure Set_Title (w : Webview_Type; title : String) is
    ctitle : Interfaces.C.Strings.chars_ptr := Interfaces.C.Strings.New_String(title);	
    err : Webview.Raw.Error := Webview.Raw.Set_Title(w, ctitle);
   begin
    Interfaces.C.Strings.Free(ctitle);
    Handle_Error(err);
   end Set_Title;
 

   procedure Set_Size
     (w : Webview_Type;
      width : Integer;
      height : Integer;
      hints : Hint) is
      err : Webview.Raw.Error := Webview.Raw.Set_Size(w, Interfaces.C.int(width), Interfaces.C.int(height), Hints);
   begin
	Handle_Error(err);
   end Set_Size;
 

   procedure Navigate (w : Webview_Type; url : String) is
    curl : Interfaces.C.Strings.chars_ptr := Interfaces.C.Strings.New_String(url);	
    err : Webview.Raw.Error := Webview.Raw.Navigate(w, curl);
   begin
    Interfaces.C.Strings.Free(curl);
    Handle_Error(err);
   end Navigate;
 

   procedure Set_Html (w : Webview_Type; html : String) is
    chtml : Interfaces.C.Strings.chars_ptr := Interfaces.C.Strings.New_String(html);	
    err : Webview.Raw.Error := Webview.Raw.Set_Html(w, chtml);
   begin
    Interfaces.C.Strings.Free(chtml);
    Handle_Error(err);
   end Set_Html;
        

   procedure Init (w : Webview_Type; js : String) is
    cjs : Interfaces.C.Strings.chars_ptr := Interfaces.C.Strings.New_String(js);	
    err : Webview.Raw.Error := Webview.Raw.Init(w, cjs);
   begin
    Interfaces.C.Strings.Free(cjs);
    Handle_Error(err);
   end Init;

   procedure Eval (w : Webview_Type; js : String) is
    cjs : Interfaces.C.Strings.chars_ptr := Interfaces.C.Strings.New_String(js);	
    err : Webview.Raw.Error := Webview.Raw.Eval(w, cjs);
   begin
    Interfaces.C.Strings.Free(cjs);
    Handle_Error(err);
   end Eval;

   -- function Bind
   --   (w : Webview_Type;
   --    name : Interfaces.C.Strings.chars_ptr;
   --    fn : access procedure
   --      (id : Interfaces.C.Strings.chars_ptr;
   --       req : Interfaces.C.Strings.chars_ptr;
   --       arg : System.Address);
   --    arg : System.Address) return Error

   procedure Unbind (w : Webview_Type; name : String) is
    cname : Interfaces.C.Strings.chars_ptr := Interfaces.C.Strings.New_String(name);	
    err : Webview.Raw.Error := Webview.Raw.Unbind(w, cname);
   begin
    Interfaces.C.Strings.Free(cname);
    Handle_Error(err);
   end Unbind;

 
   procedure Ret
     (w : Webview_Type;
      id : String;
      status : Integer;
      result : String) is
   	cid : Interfaces.C.Strings.chars_ptr := Interfaces.C.Strings.New_String(id);
	cresult : Interfaces.C.Strings.chars_ptr := Interfaces.C.Strings.New_String(result);	
	err : Webview.Raw.Error := Webview.Raw.Ret(w, cid, Interfaces.C.int(Status), cresult);
   begin
    Interfaces.C.Strings.Free(cid);
    Interfaces.C.Strings.Free(cresult);
    Handle_Error(err);
   end Ret;

   -- function Get_Version return access constant Version_Info
       
end Webview;
