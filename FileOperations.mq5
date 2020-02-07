
void OnInit()
  {
      ResetLastError();
      string InpFileName="USDJPY-None-Fractal-NNPerfect_-USDJPY_M1_method-4_lowthres-0.5_highthres-0.5_slk-5_tpk-5_trl_sl-0_trl_tp-0_fixedtp-0_spreadmult-3_tpslratio-1_signalclose-0_acc-0.8_trial-47.csv";
      int file_handle=FileOpen("/Files/"+InpFileName,FILE_READ|FILE_CSV|FILE_ANSI);
      if(file_handle!=INVALID_HANDLE)
        {
         Print("%s file is available for reading",InpFileName);
         Print("File path: %s\\Files\\",TerminalInfoString(TERMINAL_DATA_PATH));
         //--- additional variables
         int    str_size;
         string str;
         //--- read data from the file
         while(!FileIsEnding(file_handle))
           {
            //--- find out how many symbols are used for writing the time
            str_size=FileReadInteger(file_handle,INT_VALUE);
            //--- read the string
            str=FileReadString(file_handle,str_size);
            //--- print the string
            Print(str);
           }
         //--- close the file
         FileClose(file_handle);
         Print("Data is read, %s file is closed",InpFileName);
        }
      else
      {
         PrintFormat("Error code = %d", GetLastError());
      }

      
  }
  
  void onThick()
  {
      static datetime time;
      Comment("\n\nTime :",time);
  }

