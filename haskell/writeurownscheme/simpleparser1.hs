module Main where

import System.Environment
import Text.ParserCombinators.Parsec hiding (spaces)
-- except the spaces function



main :: IO ()
main = do
	args <- getArgs
	putStrLn (readExpr (args !! 0))
{-
	putStrLn("Hi, please input your name...")
	x <- getLine
	putStrLn("thanks " ++ x)

	(arg1:arg2:argRest) <- getArgs
	putStrLn ("Hello, " ++ arg1 ++ arg2)
-}

-- extra info is that it performs IO
-- and the basic value is ()
-- monadic values are often called "actions"
 -- because IO monad is a sequencing of
 -- actions that might affect the realworld


symbol :: Parser Char
symbol = oneOf "!$%&|*+-/:<=?>@^_~#"
-- monad that hides "extra info" regarding 
-- position in the input stream, backtracking record
-- first and follow sets, etc.
-- Parsec takes care of all that

-- prebuilt parsers: letter, digit

readExpr :: String -> String
readExpr input = case parse symbol "lisp" input of
	Left err -> "No match: " ++ show err
	Right val -> "Found value"
-- parse - Parsec function
-- symbol - action defined above
-- lisp - name of the parser

-- typical haskell convension - Parsec returns an Either
-- data type using Left constructor for errors and Right
-- for normal value

spaces :: Parser ()
spaces = skipMany1 space
-- pass Parser action space to skipMany1 to get 
-- a parser that will recognize one or more spaces


-- >> combines the lines of a do block
-- go to 