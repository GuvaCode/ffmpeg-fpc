//
// postprocess.h header binding for the Free Pascal Compiler aka FPC
//
// Binaries and demos available at http://www.djmaster.com/
//

(*
 * Copyright (C) 2001-2003 Michael Niedermayer (michaelni@gmx.at)
 *
 * This file is part of FFmpeg.
 *
 * FFmpeg is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * FFmpeg is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with FFmpeg; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 *)

unit postprocess;

{$mode objfpc}{$H+}

interface

uses
  ctypes;

const
  LIB_POSTPROCESS = 'postproc-54.dll';

// #ifndef POSTPROC_POSTPROCESS_H
// #define POSTPROC_POSTPROCESS_H

(**
 * @file
 * @ingroup lpp
 * external API header
 *)

(**
 * @defgroup lpp libpostproc
 * Video postprocessing library.
 *
 * @{
 *)

#include "libpostproc/version.h"

(**
 * Return the LIBPOSTPROC_VERSION_INT constant.
 *)
function postproc_version(): cunsigned; cdecl; external LIB_POSTPROCESS;

(**
 * Return the libpostproc build-time configuration.
 *)
function postproc_configuration(): pchar; cdecl; external LIB_POSTPROCESS;

(**
 * Return the libpostproc license.
 *)
function postproc_license(): pchar; cdecl; external LIB_POSTPROCESS;

const
  PP_QUALITY_MAX = 6;

{$if FF_API_QP_TYPE}
  QP_STORE_T = cint8_t; //deprecated
{$endif}

#include <inttypes.h>

typedef void pp_context;
typedef void pp_mode;

{$if LIBPOSTPROC_VERSION_INT < (52 shl 16)}
typedef pp_context pp_context_t;
typedef pp_mode pp_mode_t;
extern const pchar const pp_help; ///< a simple help text
#else
extern const char pp_help[]; ///< a simple help text
{$endif}

procedure pp_postprocess(const src: array[0..2] of pcuint8_t; const srcStride: array[0..2] of cint; dst: array[0..2] of pcuint8_t; const dstStride: array[0..2] of cint; horizontalSize: cint; verticalSize: cint; const QP_store: pcint8_t; QP_stride: cint; mode: Ppp_mode; ppContext: Ppp_context; pict_type: cint); cdecl; external LIB_POSTPROCESS;


(**
 * Return a pp_mode or NULL if an error occurred.
 *
 * @param name    the string after "-pp" on the command line
 * @param quality a number from 0 to PP_QUALITY_MAX
 *)
function pp_get_mode_by_name_and_quality(const name: pchar; quality: cint): Ppp_mode; cdecl; external LIB_POSTPROCESS;
procedure pp_free_mode(mode: Ppp_mode); cdecl; external LIB_POSTPROCESS;

function pp_get_context(width: cint; height: cint; flags: cint): Ppp_context; cdecl; external LIB_POSTPROCESS;
procedure pp_free_context(ppContext: Ppp_context); cdecl; external LIB_POSTPROCESS;

const
  PP_CPU_CAPS_MMX = $80000000;
  PP_CPU_CAPS_MMX2 = $20000000;
  PP_CPU_CAPS_3DNOW = $40000000;
  PP_CPU_CAPS_ALTIVEC = $10000000;
  PP_CPU_CAPS_AUTO = $00080000;

  PP_FORMAT = $00000008;
  PP_FORMAT_420 = ($00000011 or PP_FORMAT);
  PP_FORMAT_422 = ($00000001 or PP_FORMAT);
  PP_FORMAT_411 = ($00000002 or PP_FORMAT);
  PP_FORMAT_444 = ($00000000 or PP_FORMAT);
  PP_FORMAT_440 = ($00000010 or PP_FORMAT);

  PP_PICT_TYPE_QP2 = $00000010; ///< MPEG2 style QScale

(**
 * @}
 *)

// #endif (* POSTPROC_POSTPROCESS_H *)


implementation


end.

