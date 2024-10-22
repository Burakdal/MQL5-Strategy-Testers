#include <Trade\Trade.mqh>
CTrade trade;
void OnTick()
  {   
      
      double close=iClose(_Symbol,_Period,1);
      //double initalClose=iClose(_Symbol,_Period,2);
      double movingAvrArry[];
      int movingAvrDef=iMA(_Symbol,_Period,20,0,MODE_SMA,PRICE_CLOSE);
      CopyBuffer(movingAvrDef,0,0,3,movingAvrArry);
      float movingAvrgVal=movingAvrArry[1];
      Comment("\nClose: ",close);
      Comment("\n\nMean: ",movingAvrgVal);
      
      //Print("CLOSE %d",close);
      //Print("\nInıtıalCLOSE %d",initalClose);
      
      //int IsPositionExist=CheckPositionExist();
      //int positionType=getOpenPositionType(IsPositionExist); 
      
      if(close<movingAvrgVal)
      {
         BuyOrder();
      }
      if(close>movingAvrgVal)
      {
         SellOrder();
      }
   
  }
  
 void SellOrder()
 {
   CheckPositionExistAndClose(POSITION_TYPE_BUY);
   if(PositionsTotal()==0)
   {
      trade.Sell(0.01);
   }
   
 }
 
 void BuyOrder()
 {
 
   CheckPositionExistAndClose(POSITION_TYPE_SELL);
   if(PositionsTotal()==0)
   {
   
      trade.Buy(0.01);
   }
   
   
 }
 
 void CheckPositionExistAndClose(ENUM_POSITION_TYPE typeOfPostion)
{
      for(int i=PositionsTotal()-1;i>=0;i--)
      {
         string symbol=PositionGetSymbol(i);
            
         if(Symbol()==symbol)
         {
            ENUM_POSITION_TYPE positionType=(ENUM_POSITION_TYPE)getOpenPositionType(i);
            if(positionType==typeOfPostion)
            {
               trade.PositionClose(_Symbol);
            }
         }
      }
      
      
}

int getOpenPositionType(int i)
{
   string position_symbol=PositionGetSymbol(i);
   if(_Symbol==position_symbol)
   {
      return PositionGetInteger(POSITION_TYPE);
   }
   return NULL;
   
}

double calculateMeanOfLastCloses(int count)
{
   double total=0;
   for(int i=2;i<=count+2;i++)
   {
      total+=iClose(_Symbol,_Period,i);
   }
   return total/count;
}
  

