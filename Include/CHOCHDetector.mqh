//+------------------------------------------------------------------+
//| CHOCHDetector.mqh                                                |
//+------------------------------------------------------------------+
#ifndef __CHOCH_DETECTOR_MQH__
#define __CHOCH_DETECTOR_MQH__

#include "SwingDetector.mqh"
#include "BOSDetector.mqh"

//====================================================
// Market Structure
//====================================================
enum MARKET_STRUCTURE
{
   STRUCTURE_NONE=0,
   STRUCTURE_BULLISH=1,
   STRUCTURE_BEARISH=-1
};

MARKET_STRUCTURE CurrentStructure=STRUCTURE_NONE;

//====================================================
// Bullish CHOCH
//====================================================
bool BullishCHOCH()
{
   if(CurrentStructure==STRUCTURE_BEARISH &&
      BullishBOS())
      return(true);

   return(false);
}

//====================================================
// Bearish CHOCH
//====================================================
bool BearishCHOCH()
{
   if(CurrentStructure==STRUCTURE_BULLISH &&
      BearishBOS())
      return(true);

   return(false);
}

//====================================================
// Update Structure
//====================================================
void UpdateStructure()
{
   if(BullishCHOCH())
      CurrentStructure=STRUCTURE_BULLISH;

   if(BearishCHOCH())
      CurrentStructure=STRUCTURE_BEARISH;

   if(CurrentStructure==STRUCTURE_NONE)
   {
      if(BullishBOS())
         CurrentStructure=STRUCTURE_BULLISH;

      if(BearishBOS())
         CurrentStructure=STRUCTURE_BEARISH;
   }
}

//====================================================
// Trend
//====================================================
bool MarketBullish()
{
   return(CurrentStructure==STRUCTURE_BULLISH);
}

bool MarketBearish()
{
   return(CurrentStructure==STRUCTURE_BEARISH);
}

#endif
