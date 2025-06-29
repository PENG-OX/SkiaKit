/*
 * Copyright 2014 Google Inc.
 * Copyright 2015 Xamarin Inc.
 * Copyright 2017 Microsoft Corporation. All rights reserved.
 *
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

#ifndef sk_typeface_DEFINED
#define sk_typeface_DEFINED

#include "sk_types.h"

SK_C_PLUS_PLUS_BEGIN_GUARD

// typeface

SK_C_API void sk_typeface_unref(sk_typeface_t* typeface);
SK_C_API sk_fontstyle_t* sk_typeface_get_fontstyle(const sk_typeface_t* typeface);
SK_C_API int sk_typeface_get_font_weight(const sk_typeface_t* typeface);
SK_C_API int sk_typeface_get_font_width(const sk_typeface_t* typeface);
SK_C_API sk_font_style_slant_t sk_typeface_get_font_slant(const sk_typeface_t* typeface);
SK_C_API bool sk_typeface_is_fixed_pitch(const sk_typeface_t* typeface);
SK_C_API sk_typeface_t* sk_typeface_create_default(void);
SK_C_API sk_typeface_t* sk_typeface_ref_default(void);
SK_C_API sk_typeface_t* sk_typeface_create_from_name(const char* familyName, const sk_fontstyle_t* style);
SK_C_API sk_typeface_t* sk_typeface_create_from_file(const char* path, int index);
SK_C_API sk_typeface_t* sk_typeface_create_from_stream(sk_stream_asset_t* stream, int index);
SK_C_API sk_typeface_t* sk_typeface_create_from_data(sk_data_t* data, int index);
SK_C_API void sk_typeface_unichars_to_glyphs(const sk_typeface_t* typeface, const int32_t unichars[], int count, uint16_t glyphs[]);
SK_C_API uint16_t sk_typeface_unichar_to_glyph(const sk_typeface_t* typeface, const int32_t unichar);
SK_C_API int sk_typeface_count_glyphs(const sk_typeface_t* typeface);
SK_C_API int sk_typeface_count_tables(const sk_typeface_t* typeface);
SK_C_API int sk_typeface_get_table_tags(const sk_typeface_t* typeface, sk_font_table_tag_t tags[]);
SK_C_API size_t sk_typeface_get_table_size(const sk_typeface_t* typeface, sk_font_table_tag_t tag);
SK_C_API size_t sk_typeface_get_table_data(const sk_typeface_t* typeface, sk_font_table_tag_t tag, size_t offset, size_t length, void* data);
SK_C_API sk_data_t* sk_typeface_copy_table_data(const sk_typeface_t* typeface, sk_font_table_tag_t tag);
SK_C_API int sk_typeface_get_units_per_em(const sk_typeface_t* typeface);
SK_C_API bool sk_typeface_get_kerning_pair_adjustments(const sk_typeface_t* typeface, const uint16_t glyphs[], int count, int32_t adjustments[]);
// TODO: createFamilyNameIterator
SK_C_API sk_string_t* sk_typeface_get_family_name(const sk_typeface_t* typeface);
SK_C_API sk_stream_asset_t* sk_typeface_open_stream(const sk_typeface_t* typeface, int* ttcIndex);


// font manager

SK_C_API sk_fontmgr_t* sk_fontmgr_create_default(void);
SK_C_API sk_fontmgr_t* sk_fontmgr_ref_default(void);
SK_C_API void sk_fontmgr_unref(sk_fontmgr_t*);
SK_C_API int sk_fontmgr_count_families(sk_fontmgr_t*);
SK_C_API void sk_fontmgr_get_family_name(sk_fontmgr_t*, int index, sk_string_t* familyName);
SK_C_API sk_fontstyleset_t* sk_fontmgr_create_styleset(sk_fontmgr_t*, int index);
SK_C_API sk_fontstyleset_t* sk_fontmgr_match_family(sk_fontmgr_t*, const char* familyName);
SK_C_API sk_typeface_t* sk_fontmgr_match_family_style(sk_fontmgr_t*, const char* familyName, sk_fontstyle_t* style);
SK_C_API sk_typeface_t* sk_fontmgr_match_family_style_character(sk_fontmgr_t*, const char* familyName, sk_fontstyle_t* style, const char** bcp47, int bcp47Count, int32_t character);
SK_C_API sk_typeface_t* sk_fontmgr_create_from_data(sk_fontmgr_t*, sk_data_t* data, int index);
SK_C_API sk_typeface_t* sk_fontmgr_create_from_stream(sk_fontmgr_t*, sk_stream_asset_t* stream, int index);
SK_C_API sk_typeface_t* sk_fontmgr_create_from_file(sk_fontmgr_t*, const char* path, int index);

// font style

SK_C_API sk_fontstyle_t* sk_fontstyle_new(int weight, int width, sk_font_style_slant_t slant);
SK_C_API void sk_fontstyle_delete(sk_fontstyle_t* fs);
SK_C_API int sk_fontstyle_get_weight(const sk_fontstyle_t* fs);
SK_C_API int sk_fontstyle_get_width(const sk_fontstyle_t* fs);
SK_C_API sk_font_style_slant_t sk_fontstyle_get_slant(const sk_fontstyle_t* fs);

// font style set

SK_C_API sk_fontstyleset_t* sk_fontstyleset_create_empty(void);
SK_C_API void sk_fontstyleset_unref(sk_fontstyleset_t* fss);
SK_C_API int sk_fontstyleset_get_count(sk_fontstyleset_t* fss);
SK_C_API void sk_fontstyleset_get_style(sk_fontstyleset_t* fss, int index, sk_fontstyle_t* fs, sk_string_t* style);
SK_C_API sk_typeface_t* sk_fontstyleset_create_typeface(sk_fontstyleset_t* fss, int index);
SK_C_API sk_typeface_t* sk_fontstyleset_match_style(sk_fontstyleset_t* fss, sk_fontstyle_t* style);

SK_C_PLUS_PLUS_END_GUARD

#endif
