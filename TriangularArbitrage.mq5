#include "..\Scripts\Triangular-Arbitrage\ArbitrageCalculator.mqh"
#include "..\Scripts\Triangular-Arbitrage\Writer.mqh";
#include "..\Scripts\Triangular-Arbitrage\Symbols\SymbolInfo.mqh";
#include "..\Scripts\Triangular-Arbitrage\Symbols\SymbolTriangle.mqh";
#include "..\Scripts\Triangular-Arbitrage\Utility\SymbolList.mqh";
#include "..\Scripts\Triangular-Arbitrage\Form\FormHelper.mqh";
#include "..\Scripts\Triangular-Arbitrage\Reader\Reader.mqh";
input uint InputWait = 20;
input bool InputSendOrder = true;
Writer writer;
SymbolList list;
static int size;
bool isFormOpen=false;
int OnInit()
  {  
   if(!isFormOpen)
   {
      FormHelperOpenForm();

      //ReadSymbols();

      size = ArraySize(AllSymbols) / 3;

      writer.OpenFile();
      isFormOpen=true;
   }
   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {
      FormHelperCloseForm();

      //EventKillTimer();
  
      writer.CloseFile();
   
  }

void OnTick()
  {
      for (int i = 0; i < size; i++)
       {
   
         SymbolTriangle symbols(i);
         
         if (symbols.ForwardArbitrageValue() > 0)
         {
           if (InputSendOrder)
             symbols.MakeForwardArbitrage();
           
           list.Add(symbols);
         }
         if (symbols.BackwardArbitrageValue() > 0)
         {
           if (InputSendOrder)
             symbols.MakeBackwardArbitrage();
           
           list.Add(symbols);
         }
       }
       list.BindToForm();
       
       writer.Dump(list.GetDumpString());
       
       list.Clear();
   
  }

