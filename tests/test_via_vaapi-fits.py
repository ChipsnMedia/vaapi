
import pytest
from common import*


def test_via_vaapifits():
    ret = execute_vaapifits()
    assert ret == True
    return 

# def main():
#     return test_via_vaapifits()

# if __name__ == '__main__':
#     main()

