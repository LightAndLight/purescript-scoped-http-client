module Node.HTTP.ScopedClient where

import Prelude (($), Unit)
import Control.Monad.Aff (Aff, makeAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (Error)
import Data.Tuple (Tuple(..))
import Node.HTTP (HTTP, Response)

foreign import data ScopedClient :: *


foreign import create :: forall e. String -> Eff (http :: HTTP | e) ScopedClient


foreign import getInternal :: forall a b e. (a -> b -> Tuple a b) -> ScopedClient -> (Error -> Eff e Unit) -> (Tuple Response String -> Eff e Unit) -> Eff e Unit

get :: forall e. ScopedClient -> Aff (http :: HTTP | e) (Tuple Response String)
get client = makeAff $ getInternal Tuple client 

foreign import postInternal :: forall a b e. (a -> b -> Tuple a b) -> ScopedClient -> String -> (Error -> Eff e Unit) -> (Tuple Response String -> Eff e Unit) -> Eff e Unit

post :: forall e. ScopedClient -> String -> Aff (http :: HTTP | e) (Tuple Response String)
post client dat = makeAff $ postInternal Tuple client dat


foreign import putInternal :: forall a b e. (a -> b -> Tuple a b) -> ScopedClient -> String -> (Error -> Eff e Unit) -> (Tuple Response String -> Eff e Unit) -> Eff e Unit

put :: forall e. ScopedClient -> String -> Aff (http :: HTTP | e) (Tuple Response String)
put client dat = makeAff $ putInternal Tuple client dat


foreign import delInternal :: forall a b e. (a -> b -> Tuple a b) -> ScopedClient -> (Error -> Eff e Unit) -> (Tuple Response String -> Eff e Unit) -> Eff e Unit

del :: forall e. ScopedClient -> Aff (http :: HTTP | e) (Tuple Response String)
del client = makeAff $ delInternal Tuple client 
