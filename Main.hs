module Main where

import Data.List.Split
import Numeric
import System.Environment
import System.Exit
import System.IO
import Text.Printf

shiftTime n = map maybeShiftLine
    where maybeShiftLine l = case words l of
              [t1, "-->", t2] -> printf "%s --> %s" (shift t1) (shift t2)
              _ -> l
          shift t = toTime $ (+n) $ toSeconds t :: String 

toTime seconds = printf "%02d:%02d:%02d,%03d" h m s us
    where (digits, index) = floatToDigits 10 seconds
          wholeSeconds    = listToInt $ take index digits
          us = listToInt $ take 3 $ drop index digits 
          (totalMinutes, s) = wholeSeconds `divMod` 60
          (h, m) = totalMinutes `divMod` 60
          listToInt [] = 0
          listToInt l  = read $ concatMap show l :: Integer

toSeconds :: String -> Float
toSeconds = sum . zipWith ($) ops . map read . splitOneOf ":,"
    where ops = [(*3600), (*60), id, (/1000)]

main = do
    args <- getArgs 
    case args of
      [seconds, filename] | [(seconds', _)] <- reads seconds -> do
        subs <- readFile filename
        mapM_ putStrLn $ shiftTime seconds' $ lines subs
      _ -> do
        progName <- getProgName
        hPutStrLn stderr $ "usage: " ++ progName ++ " <seconds> <filename>"
        exitFailure
