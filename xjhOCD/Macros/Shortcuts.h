//
//  Shortcuts.h
//  xjhOCD
//
//  Created by xjhuang on 13/06/2022.
//

#ifndef Shortcuts_h
#define Shortcuts_h

/* Storyboard */
#define kLoginStoryboardWithID(__Identifier) ([[UIStoryboard storyboardWithName:@"LoginStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:__Identifier])
#define kHomeStoryboardWithID(__Identifier) ([[UIStoryboard storyboardWithName:@"HomeStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:__Identifier])
#define kStudyStoryboardWithID(__Identifier) ([[UIStoryboard storyboardWithName:@"StudyStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:__Identifier])
#define kMineStoryboardWithID(__Identifier) ([[UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:__Identifier])
#define kCommonStoryboardWithID(__Identifier) ([[UIStoryboard storyboardWithName:@"CommonStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:__Identifier])
#define kOtherSourceOrderStoryboardWithID(__Identifier) ([[UIStoryboard storyboardWithName:@"OtherSourceOrderStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:__Identifier])
#define kPhotoStoryboardWithID(__Identifier) ([[UIStoryboard storyboardWithName:@"XJPhotoStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:__Identifier])

#endif /* Shortcuts_h */
