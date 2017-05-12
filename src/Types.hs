{-# LANGUAGE FlexibleContexts #-}
module Types where

import Data.Map as M
import Control.Monad.State
import Control.Monad.Reader
import Control.Monad.Error
import Control.Monad.Identity

type Loc = Integer

type Store = M.Map Loc Type

type VEnv = M.Map Ident Loc

type FEnv = M.Map Ident TopDef

newtype Ident = Ident String deriving (Eq, Ord, Show, Read)

data Program = Program [TopDef]
  deriving (Eq, Ord, Show, Read)

data TopDef = FnDef Type Ident [Arg] Block
  deriving (Eq, Ord, Show, Read)

data Arg = Arg Type Ident
  deriving (Eq, Ord, Show, Read)

data Block = Block [Stmt]
  deriving (Eq, Ord, Show, Read)

data Stmt
    = Empty
    | BStmt Block
    | Decl Type [Item]
    | Ass Ident Expr
    | Ret Expr
    | VRet
    | Cond Expr Stmt
    | CondElse Expr Stmt Stmt
    | While Expr Stmt
    | ForTo Item Expr Stmt
    | ForDownTo Item Expr Stmt
    | SExp Expr
  deriving (Eq, Ord, Show, Read)

data Item = NoInit Ident | Init Ident Expr
  deriving (Eq, Ord, Show, Read)

data Type = Int | Str | Bool | Void | Fun Type [Type]
  deriving (Eq, Ord, Show, Read)

data ValueType = VInt Integer | VStr String | VBool Bool | VVoid
  deriving (Eq, Ord, Show, Read)

data Expr
    = EVar Ident
    | ELitInt Integer
    | ELitTrue --Bool
    | ELitFalse --Bool
    | EApp Ident [Expr]
    | EString String
    | Neg Expr
    | Not Expr
    | EMul Expr MulOp Expr
    | EAdd Expr AddOp Expr
    | ERel Expr RelOp Expr
    | EAnd Expr Expr
    | EOr Expr Expr
  deriving (Eq, Ord, Show, Read)

data AddOp = Plus | Minus
  deriving (Eq, Ord, Show, Read)

data MulOp = Times | Div
  deriving (Eq, Ord, Show, Read)

data RelOp = LTH | LE | GTH | GE | EQU | NE
  deriving (Eq, Ord, Show, Read)
