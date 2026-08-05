//+------------------------------------------------------------------+
//|                                               SMC_XAU_Pro_EA.mq5 |
//|                     Professional SMC EA v0.1                     |
//+------------------------------------------------------------------+
#property copyright "Dipu10"
#property version   "0.1"
#property strict

#include <Trade/Trade.mqh>

CTrade trade;

//===========================
// Inputs
//===========================
input double RiskPercent = 1.0;
input double RiskReward  = 3.0;

input ENUM_TIMEFRAMES TrendTF = PERIOD_H4;
input ENUM_TIMEFRAMES EntryTF = PERIOD_M15;

input ulong Magic = 20260805;

//===========================
// Global Variables
//===========================
double AskPrice;
double BidPrice;

//===========================
// Initialization
//===========================
int OnInit()
{
   trade.SetExpertMagicNumber(Magic);

   Print("SMC XAU PRO EA Started");

   return(INIT_SUCCEEDED);
}

//===========================
// DeInit
//===========================
void OnDeinit(const int reason)
{
   Print("EA Stopped");
}

//===========================
// Tick
//===========================
void OnTick()
{
   AskPrice = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   BidPrice = SymbolInfoDouble(_Symbol,SYMBOL_BID);

   if(PositionSelect(_Symbol))
   {
      ManageTrade();
      return;
   }

   CheckEntry();
}

//===========================
// Entry Logic
//===========================
void CheckEntry()
{
   // BOS
   // CHOCH
   // Liquidity Sweep
   // Order Block
   // FVG

   // এগুলো পরবর্তী ফাইলে যোগ হবে
}

//===========================
// Trade Manager
//===========================
void ManageTrade()
{
   // Break Even

   // Trailing Stop

   // Partial Close
}

//===========================
// Buy
//===========================
void OpenBuy(double sl,double tp,double lot)
{
   trade.Buy(
      lot,
      _Symbol,
      AskPrice,
      sl,
      tp,
      "SMC BUY"
   );
}

//===========================
// Sell
//===========================
void OpenSell(double sl,double tp,double lot)
{
   trade.Sell(
      lot,
      _Symbol,
      BidPrice,
      sl,
      tp,
      "SMC SELL"
   );
}//+------------------------------------------------------------------+
//|                                               SMC_XAU_Pro_EA.mq5 |
//|                     Professional SMC EA v0.1                     |
//+------------------------------------------------------------------+
#property copyright "Dipu10"
#property version   "0.1"
#property strict

#include <Trade/Trade.mqh>

CTrade trade;

//===========================
// Inputs
//===========================
input double RiskPercent = 1.0;
input double RiskReward  = 3.0;

input ENUM_TIMEFRAMES TrendTF = PERIOD_H4;
input ENUM_TIMEFRAMES EntryTF = PERIOD_M15;

input ulong Magic = 20260805;

//===========================
// Global Variables
//===========================
double AskPrice;
double BidPrice;

//===========================
// Initialization
//===========================
int OnInit()
{
   trade.SetExpertMagicNumber(Magic);

   Print("SMC XAU PRO EA Started");

   return(INIT_SUCCEEDED);
}

//===========================
// DeInit
//===========================
void OnDeinit(const int reason)
{
   Print("EA Stopped");
}

//===========================
// Tick
//===========================
void OnTick()
{
   AskPrice = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
   BidPrice = SymbolInfoDouble(_Symbol,SYMBOL_BID);

   if(PositionSelect(_Symbol))
   {
      ManageTrade();
      return;
   }

   CheckEntry();
}

//===========================
// Entry Logic
//===========================
void CheckEntry()
{
   // BOS
   // CHOCH
   // Liquidity Sweep
   // Order Block
   // FVG

   // এগুলো পরবর্তী ফাইলে যোগ হবে
}

//===========================
// Trade Manager
//===========================
void ManageTrade()
{
   // Break Even

   // Trailing Stop

   // Partial Close
}

//===========================
// Buy
//===========================
void OpenBuy(double sl,double tp,double lot)
{
   trade.Buy(
      lot,
      _Symbol,
      AskPrice,
      sl,
      tp,
      "SMC BUY"
   );
}

//===========================
// Sell
//===========================
void OpenSell(double sl,double tp,double lot)
{
   trade.Sell(
      lot,
      _Symbol,
      BidPrice,
      sl,
      tp,
      "SMC SELL"
   );
}
