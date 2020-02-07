#include <Trade\Trade.mqh>
CTrade trade;
input double myLotSize=0.10;
void OnTick()
  {
      double Ask=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
      double Balance=AccountInfoDouble(ACCOUNT_BALANCE);
      double Equity=AccountInfoDouble(ACCOUNT_EQUITY);
      if(Equity>=Balance)
      trade.Buy(myLotSize,NULL,Ask,0,(Ask+100*_Point),NULL);
  }