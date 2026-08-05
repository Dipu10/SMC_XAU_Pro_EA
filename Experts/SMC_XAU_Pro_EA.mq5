//+------------------------------------------------------------------+
//| SMC_XAU_Pro_EA.mq5                                               |
//+------------------------------------------------------------------+
#property strict
#property version "0.2"

#include <Trade/Trade.mqh>

CTrade trade;

//========================
// Includes
//========================
#include "../Include/Inputs.mqh"
#include "../Include/Utility.mqh"
#include "../Include/RiskManager.mqh"
#include "../Include/TradeManager.mqh"

#include "../Include/SwingDetector.mqh"
#include "../Include/BOSDetector.mqh"
#include "../Include/CHOCHDetector.mqh"
#include "../Include/LiquidityDetector.mqh"
#include "../Include/OrderBlockDetector.mqh"
#include "../Include/FVGDetector.mqh"

//========================
// Init
//========================
int OnInit()
{
   trade.SetExpertMagicNumber(MagicNumber);

   Print("SMC XAU PRO EA Loaded");

   return(INIT_SUCCEEDED);
}

//========================
// Tick
//========================
void OnTick()
{
   if(!SpreadOK(MaxSpread))
      return;

   UpdateStructure();

   if(PositionSelect(_Symbol))
   {
      if(UseBreakEven)
         BreakEven();

      if(UseTrailing)
         TrailStop();

      return;
   }

   //========================
   // BUY
   //========================
   if(MarketBullish())
   {
      if(BuyLiquidityConfirmed()
      && BullishOBConfirmed()
      && BullishFVGConfirmed())
      {
         Print("BUY Setup Found");
      }
   }

   //========================
   // SELL
   //========================
   if(MarketBearish())
   {
      if(SellLiquidityConfirmed()
      && BearishOBConfirmed()
      && BearishFVGConfirmed())
      {
         Print("SELL Setup Found");
      }
   }
}
