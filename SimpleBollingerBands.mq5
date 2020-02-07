#include <Trade\Trade.mqh>
CTrade trade;
input double myLotSize=0.10;
void OnTick()
  {
      double middleBArray[];
      double lowerBArray[];
      double higerBArray[];
      double Balance=AccountInfoDouble(ACCOUNT_BALANCE);
      double Equity=AccountInfoDouble(ACCOUNT_EQUITY);
      ArraySetAsSeries(middleBArray,true);
      ArraySetAsSeries(lowerBArray,true);
      ArraySetAsSeries(higerBArray,true);
      int BollBandsDef=iBands(_Symbol,_Period,20,0,3,PRICE_CLOSE);
      CopyBuffer(BollBandsDef,0,0,3,middleBArray);
      CopyBuffer(BollBandsDef,1,0,3,higerBArray);
      CopyBuffer(BollBandsDef,2,0,3,lowerBArray);
      
      double myMiddleBand=middleBArray[0];
      double myLowerBand=lowerBArray[0];
      double myHigherBand=higerBArray[0];
      double Ask=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
      
      if(Ask<=myLowerBand)
      {
         BuyOrder();
      }else if(Ask>=myHigherBand)
      {
         SellOrder();
      }
      
      Comment("\n Upper Bound: ",myHigherBand,"\nMiddle Bound: ",myMiddleBand,"\nLower Bound: ",myLowerBand);
      Comment("\n\nAccount Balance: ",Balance);
      
   
  }
  
  void BuyOrder()
  {
      double Ask=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
      double Balance=AccountInfoDouble(ACCOUNT_BALANCE);
      double Equity=AccountInfoDouble(ACCOUNT_EQUITY);
      if(Equity>=Balance)
      trade.Buy(myLotSize,NULL,Ask,0,(Ask+100*_Point),NULL);
     
  }
  void SellOrder()
  {
      double Bid=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
      double Balance=AccountInfoDouble(ACCOUNT_BALANCE);
      double Equity=AccountInfoDouble(ACCOUNT_EQUITY);
      if(Equity>=Balance)
      trade.Sell(myLotSize,NULL,Bid,0,(Bid-100*_Point),NULL);
      
  }

