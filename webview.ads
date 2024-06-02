with Interfaces.C.Strings;	
with Interfaces.C;
with System;

package Webview is

   type Version is record
      major : Interfaces.C.unsigned;
      minor : Interfaces.C.unsigned;
      patch : Interfaces.C.unsigned;
   end record
   with Convention => C_Pass_By_Copy;
   
   type Version_Info is record
      version_t : Version;
      version_number : Interfaces.C.char_array (0 .. 31);
      pre_release : Interfaces.C.char_array (0 .. 47);
      build_metadata : Interfaces.C.char_array (0 .. 47);
   end record
   with Convention => C_Pass_By_Copy;	
      
   type Webview_Type is new System.Address;
       
   type Native_Handle_Kind is 
     (UI_Window,
      UI_Widget,
      Browser_Controller)
   with Convention => C;

   type Hint is 
     (None,
      Min,
      Max,
      Fixed)
   with Convention => C; 

   Webview_Error : exception; 

   function Create (debug : Boolean := False; window : System.Address := System.Null_Address) return Webview_Type;

   procedure Destroy (w : Webview_Type);

   procedure Run (w : Webview_Type);


   procedure Terminate_It (w : Webview_Type);
   
   procedure Dispatch
     (w : Webview_Type;
      fn : access procedure (w : Webview_Type; arg : System.Address);
      arg : System.Address);

   function Get_Window (w : Webview_Type) return System.Address;
 

   function Get_Native_Handle (w : Webview_Type; kind : Native_Handle_Kind) return System.Address;
 

   procedure Set_Title (w : Webview_Type; title : String);
 

   procedure Set_Size
     (w : Webview_Type;
      width : Integer;
      height : Integer;
      hints : Hint);
 

   procedure Navigate (w : Webview_Type; url : String);
 

   procedure Set_Html (w : Webview_Type; html : String);
        

   procedure Init (w : Webview_Type; js : String);

   procedure Eval (w : Webview_Type; js : String);	
   	     	  
   procedure Bind
     (w : Webview_Type;
      name : String;
      fn : access procedure
        (id : Interfaces.C.Strings.chars_ptr;
         req : Interfaces.C.Strings.chars_ptr;
         arg : System.Address);
      arg : System.Address);

   procedure Unbind (w : Webview_Type; name : String);

 
   procedure Ret
     (w : Webview_Type;
      id : String;
      status : Integer;
      result : String);		    	       

  function Get_Version return access constant Version_Info;      	     

package Raw is

   type Error is new Interfaces.C.int;
   Error_Missing_Dependency : constant Error := -5;
   Error_Canceled : constant Error := -4;
   Error_Invalid_State : constant Error := -3;
   Error_Invalid_Argument : constant Error := -2;
   Error_Unspecified : constant Error := -1;
   Error_Ok : constant Error := 0;
   Error_Duplicate : constant Error := 1;
   Error_Not_Found : constant Error := 2;

   function Create (debug : Interfaces.C.int; window : System.Address) return Webview_Type
   with Import => True, 
        Convention => C, 
        External_Name => "webview_create";
		
   function Destroy (w : Webview_Type) return Error
   with Import => True, 
        Convention => C, 
        External_Name => "webview_destroy";
	
   function Run (w : Webview_Type) return Error
   with Import => True, 
        Convention => C, 
        External_Name => "webview_run";

   function Terminate_It (w : Webview_Type) return Error
   with Import => True, 
        Convention => C, 
        External_Name => "webview_terminate";
 
   function Dispatch
     (w : Webview_Type;
      fn : access procedure (w : Webview_Type; arg : System.Address);
      arg : System.Address) return Error
   with Import => True, 
        Convention => C, 
        External_Name => "webview_dispatch";
 
   function Get_Window (w : Webview_Type) return System.Address
   with Import => True, 
        Convention => C, 
        External_Name => "webview_get_window";
 
   function Get_Native_Handle (w : Webview_Type; kind : Native_Handle_Kind) return System.Address
   with Import => True, 
        Convention => C, 
        External_Name => "webview_get_native_handle";
 
   function Set_Title (w : Webview_Type; title : Interfaces.C.Strings.chars_ptr) return Error
   with Import => True, 
        Convention => C, 
        External_Name => "webview_set_title";
 
   function Set_Size
     (w : Webview_Type;
      width : Interfaces.C.int;
      height : Interfaces.C.int;
      hints : Hint) return Error
   with Import => True, 
        Convention => C, 
        External_Name => "webview_set_size";
 
   function Navigate (w : Webview_Type; url : Interfaces.C.Strings.chars_ptr) return Error
   with Import => True, 
        Convention => C, 
        External_Name => "webview_navigate";
 
   function Set_Html (w : Webview_Type; html : Interfaces.C.Strings.chars_ptr) return Error
   with Import => True, 
        Convention => C, 
        External_Name => "webview_set_html";
		
   function Init (w : Webview_Type; js : Interfaces.C.Strings.chars_ptr) return Error
   with Import => True, 
        Convention => C, 
        External_Name => "webview_init";
	
   function Eval (w : Webview_Type; js : Interfaces.C.Strings.chars_ptr) return Error
   with Import => True, 
        Convention => C, 
        External_Name => "webview_eval";
		
   function Bind
     (w : Webview_Type;
      name : Interfaces.C.Strings.chars_ptr;
      fn : access procedure
        (id : Interfaces.C.Strings.chars_ptr;
         req : Interfaces.C.Strings.chars_ptr;
         arg : System.Address);
      arg : System.Address) return Error
   with Import => True, 
        Convention => C, 
        External_Name => "webview_bind";	
	
   function Unbind (w : Webview_Type; name : Interfaces.C.Strings.chars_ptr) return Error
   with Import => True, 
        Convention => C, 
        External_Name => "webview_unbind";	
	
   function Ret
     (w : Webview_Type;
      id : Interfaces.C.Strings.chars_ptr;
      status : Interfaces.C.int;
      result : Interfaces.C.Strings.chars_ptr) return Error
   with Import => True, 
        Convention => C, 
        External_Name => "webview_return";	
	
   function Get_Version return access constant Version_Info
   with Import => True, 
        Convention => C, 
        External_Name => "webview_version";	
			 
end Raw;

end Webview;
