from typing import NewType

from pydantic import Field
from typing_extensions import Annotated

# ----------------------------
# Base hex string type
# ----------------------------
hexstr = Annotated[str, Field(pattern=r'^[0-9a-f]+$')]

# ----------------------------
# Fixed-length hex strings
# ----------------------------
hexstr64 = Annotated[
    str, Field(min_length=64, max_length=64, pattern=r'^[0-9a-f]+$')]
hexstr128 = Annotated[
    str, Field(min_length=128, max_length=128, pattern=r'^[0-9a-f]+$')]

# ----------------------------
# Semantic types
# ----------------------------
AccountNumber = NewType('AccountNumber', hexstr64)
SigningKey = NewType('SigningKey', hexstr64)
Signature = NewType('Signature', hexstr128)
