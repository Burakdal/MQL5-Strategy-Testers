
void OnTick()
  {
      double myRsiArray[];
      
      int RsiDef=iRSI(_Symbol,_Period,14,PRICE_CLOSE);
      ArraySetAsSeries(myRsiArray,true);
      
      CopyBuffer(RsiDef,0,0,3,myRsiArray);
      
      double myRsiVal=NormalizeDouble(myRsiArray[0],2);
      
      Comment("\nMy RSI val: ",myRsiVal);
   
  }

