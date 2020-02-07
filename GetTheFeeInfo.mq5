
void OnTick()
  {
      double swapLongTrades=SymbolInfoDouble(Symbol(),SYMBOL_SWAP_LONG);
      double swapShortTrades=SymbolInfoDouble(Symbol(),SYMBOL_SWAP_SHORT);
      
      
      Comment("\n\nSwap Long Fee: ",swapLongTrades,"\n\nSwap Short Fee ",swapShortTrades);
   
  }

