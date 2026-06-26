{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( someFunc
    ) where

import qualified Data.Text.IO as T
import Text.Pandoc.Utils

someFunc :: IO()
someFunc = T.putStrLn "hello, world!"
