//+------------------------------------------------------------------+
//| Utility.mqh                                                      |
//+------------------------------------------------------------------+
#ifndef __UTILITY_MQH__
#define __UTILITY_MQH__

#include <Trade\SymbolInfo.mqh>

//====================================================
// Get Ask
//====================================================
double GetAsk()
{
   return SymbolInfoDouble(_Symbol,SYMBOL_ASK);
}

//====================================================
// Get Bid
//====================================================
double GetBid()
{
   return SymbolInfoDouble(_Symbol,SYMBOL_BID);
}

//====================================================
// Spread
//====================================================
double GetSpread()
{
   return (double)SymbolInfoInteger(_Symbol,SYMBOL_SPREAD);
}

//====================================================
// Spread Filter
//====================================================
bool SpreadOK(double MaxSpread)
{
   return(GetSpread()<=MaxSpread);
}

//====================================================
// Normalize Price
//====================================================
double NormalizePrice(double price)
{
   return NormalizeDouble(price,_Digits);
}

//====================================================
// Pip Value
//====================================================
double Pip()
{
   if(_Digits==3 || _Digits==5)
      return _Point*10;

   return _Point;
}

//====================================================
// Current Time
//====================================================
datetime Now()
{
   return TimeCurrent();
}

#endif
