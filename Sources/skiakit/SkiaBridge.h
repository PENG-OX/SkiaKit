#ifndef SkiaBridge_h
#define SkiaBridge_h

#include <windows.h> // 导入 Windows SDK
#include "../include/skia/gr_context.h"
#include "../include/skia/skottie_animation.h"
#include "../include/skia/skresources_resource_provider.h"
#include "../include/skia/sksg_invalidation_controller.h"
#include "../include/skia/sk_bitmap.h"
#include "../include/skia/sk_blender.h"
#include "../include/skia/sk_canvas.h"
#include "../include/skia/sk_codec.h"
#include "../include/skia/sk_colorfilter.h"
#include "../include/skia/sk_colorspace.h"
#include "../include/skia/sk_data.h"
#include "../include/skia/sk_document.h"
#include "../include/skia/sk_drawable.h"
#include "../include/skia/sk_font.h"
#include "../include/skia/sk_general.h"
#include "../include/skia/sk_graphics.h"
#include "../include/skia/sk_image.h"
#include "../include/skia/sk_imagefilter.h"
#include "../include/skia/sk_linker.h"
#include "../include/skia/sk_maskfilter.h"
#include "../include/skia/sk_matrix.h"
#include "../include/skia/sk_paint.h"
#include "../include/skia/sk_path.h"
#include "../include/skia/sk_patheffect.h"
#include "../include/skia/sk_picture.h"
#include "../include/skia/sk_pixmap.h"
#include "../include/skia/sk_region.h"
#include "../include/skia/sk_rrect.h"
#include "../include/skia/sk_runtimeeffect.h"
#include "../include/skia/sk_shader.h"
#include "../include/skia/sk_stream.h"
#include "../include/skia/sk_string.h"
#include "../include/skia/sk_surface.h"
#include "../include/skia/sk_svg.h"
#include "../include/skia/sk_textblob.h"
#include "../include/skia/sk_typeface.h"
#include "../include/skia/sk_types.h"
#include "../include/skia/sk_vertices.h"

// 声明 Skia 相关的 C 函数
typedef struct sk_surface_t sk_surface_t;

// 声明用于窗口创建和绘制的函数
void SkiaWindow_Initialize(int width, int height);
void SkiaWindow_SetSurface(sk_surface_t* surface);
int SkiaWindow_RunLoop(void);
void SkiaWindow_Cleanup(void);

#endif /* SkiaBridge_h */