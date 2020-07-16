/*************************************************************************/
/*  border_color.mm                                                      */
/*************************************************************************/

#if defined(TOOLS_ENABLED)

#include "platform/osx/display_server_osx.h"

extern "C" void _set_title_color(const Color &p_color) {
	[((DisplayServerOSX *)(DisplayServerOSX::get_singleton()))->windows[DisplayServer::MAIN_WINDOW_ID].window_object setTitlebarAppearsTransparent:YES];
	[((DisplayServerOSX *)(DisplayServerOSX::get_singleton()))->windows[DisplayServer::MAIN_WINDOW_ID].window_object setBackgroundColor:[NSColor colorWithCalibratedRed:p_color.r green:p_color.g blue:p_color.b alpha:1.f]];
}

extern "C" void _unset_title_color() {
	[((DisplayServerOSX *)(DisplayServerOSX::get_singleton()))->windows[DisplayServer::MAIN_WINDOW_ID].window_object setTitlebarAppearsTransparent:NO];
	[((DisplayServerOSX *)(DisplayServerOSX::get_singleton()))->windows[DisplayServer::MAIN_WINDOW_ID].window_object setBackgroundColor:[NSColor colorWithCalibratedWhite:1.f alpha:1.f]];
}

#endif
