//+------------------------------------------------------------------+
//| SwingDetector.mqh                                                |
//+------------------------------------------------------------------+
#ifndef __SWING_DETECTOR_MQH__
#define __SWING_DETECTOR_MQH__

//=====================================================
// Swing High
//=====================================================
bool IsSwingHigh(int shift,int length)
{
   double high=iHigh(_Symbol,EntryTF,shift);

   for(int i=1;i<=length;i++)
   {
      if(iHigh(_Symbol,EntryTF,shift-i)>=high)
         return(false);

      if(iHigh(_Symbol,EntryTF,shift+i)>high)
         return(false);
   }

   return(true);
}

//=====================================================
// Swing Low
//=====================================================
bool IsSwingLow(int shift,int length)
{
   double low=iLow(_Symbol,EntryTF,shift);

   for(int i=1;i<=length;i++)
   {
      if(iLow(_Symbol,EntryTF,shift-i)<=low)
         return(false);

      if(iLow(_Symbol,EntryTF,shift+i)<low)
         return(false);
   }

   return(true);
}

//=====================================================
// Last Swing High
//=====================================================
double GetLastSwingHigh()
{
   for(int i=SwingLength+2;i<300;i++)
   {
      if(IsSwingHigh(i,SwingLength))
         return(iHigh(_Symbol,EntryTF,i));
   }

   return(0.0);
}

//=====================================================
// Last Swing Low
//=====================================================
double GetLastSwingLow()
{
   for(int i=SwingLength+2;i<300;i++)
   {
      if(IsSwingLow(i,SwingLength))
         return(iLow(_Symbol,EntryTF,i));
   }

   return(0.0);
}

//=====================================================
// Current High
//=====================================================
double CurrentHigh()
{
   return(iHigh(_Symbol,EntryTF,1));
}

//=====================================================
// Current Low
//=====================================================
double CurrentLow()
{
   return(iLow(_Symbol,EntryTF,1));
}

#endif
