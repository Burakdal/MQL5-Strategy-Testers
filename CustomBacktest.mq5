datetime times[];
int positions[];
double StopLoss[];
double TargetProfit[];
double PredictedFractal[];
double EntryPrice[];
double TrueFractal[];
static int counter=0;
#include <Strings\String.mqh>
#include <Trade\Trade.mqh>
CTrade trade;
input string ModelId="62499";
static bool fileDownloaded=false;
static string path="";
static int linesCount=0;
#import "DownloadModel.dll"
#import
void OnTick()
  { 
   
   if(!fileDownloaded)
   {
      Print("Mapping...");
      path=DownloadClass::Download(ModelId);
      mapFileToArrays(path);
      fileDownloaded=true;
      Print("Mapping is  Finished!!");
   }
   
   {    
      datetime currentTime = TimeGMT();
      int index=ArrayFind(times,currentTime);
      if(index!=-1)
      {
         if(positions[index]==1)
         {
            Print("Buy Order : ",currentTime);
            BuyOrder(StopLoss[index],TargetProfit[index]);
            
         }else if(positions[index]==0)
         {
            Print("Close Position : ",currentTime);
            closeAllPositions();
            
         }
      }
      
      
   }
   
   
   
   
  
   
     
   
   
   
}

int ArrayFind(datetime &arr [], datetime toSearch)
{
  int size = ArraySize(arr);
  
  for (int i = 0; i < size; i++)
    if (arr[i] == toSearch)
      return i;
  
  return -1;
}

void mapFileToArrays(string path)
{
   ushort ch = '\n';
   ushort u_sep=StringGetCharacter("\n",0);
   string lines[];
   int k=StringSplit(path,ch,lines);
   ArrayResize(times,k-1);
   ArrayResize(positions,k-1);
   ArrayResize(StopLoss,k-1);
   ArrayResize(TargetProfit,k-1);
   ArrayResize(PredictedFractal,k-1);
   ArrayResize(EntryPrice,k-1);
   ArrayResize(TrueFractal,k-1);
   int counter=0;
   for (int i=0;i<k;i++)
   {  
      
      string line=lines[i];
      ushort u_sep=StringGetCharacter(",",0);
      string result[];
      int l=StringSplit(line,u_sep,result);
      
      
      CString str();
      str.Assign(result[1]);
      str.Replace("\"", "");
      string newStr = str.Str();
      if(l==8)
      {  
         times[counter]=StringToTime(newStr);
         positions[counter]=StringToInteger(result[7]);
         TrueFractal[counter]=StringToDouble(result[6]);
         PredictedFractal[counter]=StringToDouble(result[5]);
         EntryPrice[counter]=StringToDouble(result[4]);
         TargetProfit[counter]=StringToDouble(result[3]);
         StopLoss[counter]=StringToDouble(result[2]);
         counter+=1; 
      }
      
   }
   
}
void BuyOrder(double sl,double tp)
 {
 
   CheckPositionExistAndClose(POSITION_TYPE_SELL);
   if(PositionsTotal()==0)
   {
   
      trade.Buy(0.01,NULL,0,sl,tp);
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

void closeAllPositions()
{
   for(int i=PositionsTotal()-1;i>=0;i--)
      {
         string symbol=PositionGetSymbol(i);
            
         if(Symbol()==symbol)
         {
            trade.PositionClose(_Symbol);
         }
      }
}


