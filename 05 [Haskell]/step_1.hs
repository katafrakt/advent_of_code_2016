import Data.Digest.Pure.MD5
import Data.ByteString.Lazy.Char8

checkSuffix string suffix list = do
  if Prelude.length list == 8
    then print $ list
    else do
      let candidate = append string (pack (show suffix))
      let md5string = pack (show (md5 candidate))
      case stripPrefix (pack "00000") md5string of
         Just _ -> checkSuffix string (suffix + 1) (list ++ [(show md5string) !! 6])
         Nothing -> checkSuffix string (suffix + 1) list

main = do
  -- let doorName = pack "abc"
  let doorName = pack "ugkcyxxp"
  checkSuffix doorName 1 []
