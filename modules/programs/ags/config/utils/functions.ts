import GLib from "gi://GLib"
import { execAsync } from "astal/process"
import { readFileAsync } from "astal/file"

export const user_cache_home = GLib.getenv("XDG_CACHE_HOME");

export function hashFilePath(path) {
  const canonical = GLib.canonicalize_filename(path, "/")
  return GLib.compute_checksum_for_string(GLib.ChecksumType.SHA1, canonical, -1)
}

export function fileExists(path) {
  return GLib.file_test(path, GLib.FileTest.EXISTS)
}

export function dirExists(path) {
  return GLib.file_test(path, GLib.FileTest.IS_DIR)
}

export function range(min: number, max: number): number[] {
  const len = max - min + 1
  const result = new Array(len)

  for (let i = 0; i < len; i++) {
    result[i] = min + i
  }

  return result
}

export async function blurImage(power: number, path: string) {
  const CACHE_DIR = user_cache_home + "/astal/blurred_images/"
  const blurredPath = CACHE_DIR + hashFilePath(path);

  if (fileExists(blurredPath)) return blurredPath
  if (!dirExists(CACHE_DIR)) GLib.mkdir_with_parents(CACHE_DIR, 0o755)

  await execAsync(["magick", path, "-gaussian-blur", `0x${power}`, blurredPath])

  return blurredPath;
}

