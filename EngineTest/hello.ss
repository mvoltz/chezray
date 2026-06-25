;; windows-ffi.ss

;; 1. Load the standard Windows User32 DLL
(load-shared-object "user32.dll")

;; 2. Map the MessageBoxA C function to Scheme
;; The Win32 API usually uses the __stdcall calling convention,
;; so we explicitly tell Chez Scheme to use that here.
(define win-message-box
  (foreign-procedure "MessageBoxA" 
                     (void* string string unsigned-32) 
                     int))

;; 3. Call the function to trigger the pop-up!
;; Arguments:
;; - 0 (NULL pointer for the owner window)
;; - "Hello from Chez Scheme!" (The message text)
;; - "DLL Success" (The window title)
;; - 0 (The flag for a standard "OK" button)
(win-message-box 0 "Hello from Chez Scheme!" "DLL Success" 0)
