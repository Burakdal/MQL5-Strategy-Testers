#include <Trade\Trade.mqh>
void OnTick()
  {
   
   double myAccountBalance=AccountInfoDouble(ACCOUNT_BALANCE);
   double myAccountProfit=AccountInfoDouble(ACCOUNT_PROFIT);
   double myAccountEquity=AccountInfoDouble(ACCOUNT_EQUITY);
   Comment("Account Balance: ",myAccountBalance,"\nAccount Profit: ",myAccountProfit,"\nAccount Equity: ",myAccountEquity);
   MqlTradeRequest myRequest;
   MqlTradeResult myResult;
   ZeroMemory(myRequest);
   myRequest.action=TRADE_ACTION_DEAL;
   myRequest.type=ORDER_TYPE_BUY;
   myRequest.symbol=_Symbol;
   myRequest.volume=0.01;
   myRequest.type_filling=ORDER_FILLING_FOK;
   myRequest.price=SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   myRequest.tp=0;
   myRequest.deviation=50;
   if(!PositionSelect(_Symbol))
   {
      OrderSend(myRequest,myResult);
   }
   if((myAccountEquity-myAccountBalance)>2)
   {
      CloseAllOrders();
   }
   
   
  }
  void CloseAllOrders()
  {
      CTrade trade;
      int i=PositionsTotal()-1;
      while(i>=0)
      {
         if(trade.PositionClose(PositionGetSymbol(i)))i--;
      }
  }