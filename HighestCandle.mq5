//+------------------------------------------------------------------+
//|                                                HighestCandle.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"


void OnTick()
  {
      double HighesCandleM1;
      double High[];
      ArraySetAsSeries(High,true);
      CopyHigh(_Symbol,PERIOD_M1,0,11,High);
      HighesCandleM1=ArrayMaximum(High,0,11);
      Comment("\nMaximum candle within last ten is ",HighesCandleM1);      
  }

