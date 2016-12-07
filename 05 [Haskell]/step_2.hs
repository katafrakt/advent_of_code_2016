import Data.Digest.Pure.MD5
import Data.ByteString.Lazy.Char8
import Data.Char

checkSuffix string suffix list = do
  if not (Prelude.any (== '_') list)
    then print $ list
    else do
      let candidate = append (pack string) (pack (show suffix))
      let md5string = pack (show (md5 candidate))
      case stripPrefix (pack "00000") md5string of
         Just _ -> do
           let source = (show md5string)
           let positionString = source !! 6
           if (isDigit positionString) && (digitToInt positionString < 8)
             then do
               let position = digitToInt positionString
               let value = source !! 7
               let currentValue = list !! position
               if currentValue == '_'
                 then do
                   let newList = replaceNth list position value
                   checkSuffix string (suffix + 1) newList
                 else checkSuffix string (suffix + 1) list
               else checkSuffix string (suffix + 1) list
         Nothing -> checkSuffix string (suffix + 1) list

replaceNth list n newElement = Prelude.take n list ++ [newElement] ++ Prelude.drop (n + 1) list

main = do
  -- let doorName = "abc"
  let doorName = "ugkcyxxp"
  checkSuffix doorName 1 ['_', '_', '_', '_', '_', '_', '_', '_']
