//
//  Enums.h
//  Eradat
//
//  Created by Soomro Shahid on 6/24/15.
//  Copyright (c) 2015 Muzamil Hassan. All rights reserved.
//

#ifndef Eradat_Enums_h
#define Eradat_Enums_h

typedef enum
{
    eTagControllerSplash,
    eTagControllerLogin,
    eTagControllerForgotPassword,
    eTagControllerRegister,
    eTagControllerUserDashBoardController,
    eTagControllerDriverDashBoardController,
    eTagControllerJourneyPlannerController,
    eTagControllerScheduleResult,
    eTagControllerContactUs,
    eTagControllerSetting,
    eTagControllerChangePassword,
    eTagControllerOffer,
    eTagControllerNotification,
    eTagControllerNotificationDetail,
    eTagControllerFavourite,
    eTagControllerMapView,
    eTagControllerEditProfile,
} eTagController;

typedef enum
{
    ePickerTypeNone,   //0
    ePickerTypeCompany,//1
    ePickerTypeCity,   //2
    ePickerTypeArrivalDate,   //
    ePickerTypeStartTime,
    ePickerTypeEndTime,
} ePickerType;

typedef enum
{
    eJourneyCellLblBusNo = 1,
    eJourneyCellLblDriverName,
    eJourneyCellLblLocFrom,
    eJourneyCellLblLocTo,
    eJourneyCellLblDays,
    eJourneyCellLblVacations,
    eJourneyCellLblStartTime,
    eJourneyCellLblEndTime,
    
} eJourneyCellLbl;


#endif
