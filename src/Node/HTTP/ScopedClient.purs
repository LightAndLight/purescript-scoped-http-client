module Node.HTTP.ScopedClient where

import Prelude (($), Unit)
import Control.Monad.Aff (Aff, makeAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (Error)
import Data.Tuple (Tuple(..))
import Node.HTTP (HTTP)
import Node.HTTP.Client (Response)

foreign import data ScopedClient :: *


foreign import create :: forall e. String -> Eff (http :: HTTP | e) ScopedClient


foreign import getInternal :: forall a b e. (a -> b -> Tuple a b) -> ScopedClient -> (Error -> Eff e Unit) -> (Tuple Response String -> Eff e Unit) -> Eff e Unit

get :: forall e. ScopedClient -> Aff (http :: HTTP | e) (Tuple Response String)
get client = makeAff $ getInternal Tuple client 
