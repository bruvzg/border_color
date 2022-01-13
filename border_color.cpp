/*************************************************************************/
/*  border_color.cpp                                                     */
/*************************************************************************/

#include "register_types.h"

#if defined(TOOLS_ENABLED)

#include "core/config/project_settings.h"
#include "editor/editor_node.h"
#include "editor/editor_settings.h"

#if defined(OSX_ENABLED)
extern "C" void _set_title_color(const Color &p_color);
extern "C" void _unset_title_color();
#endif

class EditorBorderColorPlugin : public EditorPlugin {
	GDCLASS(EditorBorderColorPlugin, EditorPlugin);

	EditorNode *editor_node = nullptr;
	Color editor_color;

protected:
	void _notification(int p_what) {
		if (p_what == NOTIFICATION_PROCESS) {
			Color base_color = GLOBAL_GET("editor/border_color");
			if (editor_color != base_color) {
				editor_color = base_color;
				if (editor_color != Color()) {
#if defined(OSX_ENABLED)
					_set_title_color(base_color);
#endif
					Ref<StyleBoxFlat> style;
					style.instantiate();
					style->set_bg_color(base_color);
					editor_node->get_gui_base()->add_theme_style_override("panel", style);
				} else {
#if defined(OSX_ENABLED)
					_unset_title_color();
#endif
					editor_node->get_gui_base()->add_theme_style_override("panel", Ref<StyleBox>());
				}
			}
		}
	}

public:
	bool has_main_screen() const override { return false; }
	virtual String get_name() const override { return "BorderColor"; }
	virtual void edit(Object *p_object) override { };
	virtual bool handles(Object *p_object) const override { return false; }
	virtual void make_visible(bool p_visible) override {}

	EditorBorderColorPlugin(EditorNode *p_node) {
		GLOBAL_DEF("editor/border_color", Color());
		editor_node = p_node;
		set_process(true);
	};
	~EditorBorderColorPlugin() {};
};

static void _editor_init() {
	EditorPlugin *_editor = memnew(EditorBorderColorPlugin(EditorNode::get_singleton()));
	EditorNode::add_editor_plugin(_editor);
}

#endif

void register_border_color_types() {
#if defined(TOOLS_ENABLED)
	EditorNode::add_init_callback(_editor_init);
#endif
}

void unregister_border_color_types() {}
