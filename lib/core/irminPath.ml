(*
 * Copyright (c) 2013 Thomas Gazagnaire <thomas@gazagnaire.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

open Core_kernel.Std

module M = struct
  type nonrec t = string list
  with bin_io, compare, sexp
  let hash (t : t) = Hashtbl.hash t
  let to_string t =
    String.concat ~sep:"/" t
  let of_string str =
    List.filter
      ~f:(fun s -> not (String.is_empty s))
      (String.split str ~on:'/')
  let module_name = "Path"
end
include M
include Identifiable.Make (M)

let of_raw = of_string
let to_raw = to_string

let to_json = Ezjsonm.list Ezjsonm.string

let of_json = Ezjsonm.get_list Ezjsonm.get_string

let of_bytes str =
  failwith "Path.of_bytes: ???"

let of_bigarray ba =
  failwith "Path.of_bigarray: ???"
