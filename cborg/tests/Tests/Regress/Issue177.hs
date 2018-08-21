{-# LANGUAGE OverloadedStrings #-}

module Tests.Regress.Issue177 where

import Data.Word
import Control.Monad
import Codec.CBOR.Read
import Codec.CBOR.Decoding
import Test.Tasty
import Test.Tasty.HUnit

faulty :: Decoder s Word32
faulty = do
    void $ decodeBytes
    decodeWord32

main :: IO ()
main = do
  print $ deserialiseFromBytes faulty "[\130\128>\ACK\220\166\209" -- This works fine and returns an error
  print $ deserialiseFromBytes faulty "[\130\128>\ACK\220\166\209anybytesequence" -- This segfaults

testTree :: TestTree
testTree = testCase "Decoding arbitrary bytestring doesn't crash (#177)" main
