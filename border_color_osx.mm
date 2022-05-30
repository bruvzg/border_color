/*************************************************************************/
/*  border_color.mm                                                      */
/*************************************************************************/

#if defined(TOOLS_ENABLED)

#include "platform/osx/display_server_osx.h"

extern "C" void _set_title_color(const Color &p_color) {
	NSWindow *window = (__bridge NSWindow *)(void *)DisplayServer::get_singleton()->window_get_native_handle(DisplayServer::WINDOW_HANDLE, DisplayServer::MAIN_WINDOW_ID);
	[window setTitlebarAppearsTransparent:YES];
	[window setBackgroundColor:[NSColor colorWithCalibratedRed:p_color.r green:p_color.g blue:p_color.b alpha:1.f]];
}

extern "C" void _unset_title_color() {
	NSWindow *window = (__bridge NSWindow *)(void *)DisplayServer::get_singleton()->window_get_native_handle(DisplayServer::WINDOW_HANDLE, DisplayServer::MAIN_WINDOW_ID);
	[window setTitlebarAppearsTransparent:NO];
	[window setBackgroundColor:[NSColor colorWithCalibratedWhite:1.f alpha:1.f]];
}

#endif
