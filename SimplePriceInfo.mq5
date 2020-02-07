
void OnTick()
  {
      MqlRates PriceInformation[];
      ArraySetAsSeries(PriceInformation,true);
      int Data=CopyRates(Symbol(),Period(),0,Bars(Symbol(),Period()),PriceInformation);
      
      if(PriceInformation[1].close>PriceInformation[2].close)Comment("It is going up");
      if(PriceInformation[1].close<PriceInformation[2].close)Comment("It is going down");
      
   
  }

