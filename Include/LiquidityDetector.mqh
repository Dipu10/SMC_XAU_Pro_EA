//+------------------------------------------------------------------+
//| LiquidityDetector.mqh                                            |
//+------------------------------------------------------------------+
#ifndef __LIQUIDITY_DETECTOR_MQH__
#define __LIQUIDITY_DETECTOR_MQH__

#include "SwingDetector.mqh"

//====================================================
// Equal High
//====================================================
bool EqualHigh(int shift1,int shift2,double tolerance)
{
   double h1=iHigh(_Symbol,EntryTF,shift1);
   double h2=iHigh(_Symbol,EntryTF,shift2);

   return(MathAbs(h1-h2)<=tolerance*_Point);
}

//====================================================
// Equal Low
//====================================================
bool EqualLow(int shift1,int shift2,double tolerance)
{
   double l1=iLow(_Symbol,EntryTF,shift1);
   double l2=iLow(_Symbol,EntryTF,shift2);

   return(MathAbs(l1-l2)<=tolerance*_Point);
}

//====================================================
// Buy Side Liquidity
//====================================================
bool BuySideLiquidity()
{
   for(int i=5;i<LiquidityLookBack;i++)
   {
      if(EqualHigh(i,i+1,10))
         return(true);
   }

   return(false);
}

//====================================================
// Sell Side Liquidity
//====================================================
bool SellSideLiquidity()
{
   for(int i=5;i<LiquidityLookBack;i++)
   {
      if(EqualLow(i,i+1,10))
         return(true);
   }

   return(false);
}

//====================================================
// Buy Side Sweep
//====================================================
bool BuySideSweep()
{
   double high=GetLastSwingHigh();

   if(high==0)
      return(false);

   double candleHigh=iHigh(_Symbol,EntryTF,1);
   double candleClose=iClose(_Symbol,EntryTF,1);

   return(candleHigh>high && candleClose<high);
}

//====================================================
// Sell Side Sweep
//====================================================
bool SellSideSweep()
{
   double low=GetLastSwingLow();

   if(low==0)
      return(false);

   double candleLow=iLow(_Symbol,EntryTF,1);
   double candleClose=iClose(_Symbol,EntryTF,1);

   return(candleLow<low && candleClose>low);
}

//====================================================
// Confirmation
//====================================================
bool BuyLiquidityConfirmed()
{
   return(SellSideSweep());
}

bool SellLiquidityConfirmed()
{
   return(BuySideSweep());
}

#endif
