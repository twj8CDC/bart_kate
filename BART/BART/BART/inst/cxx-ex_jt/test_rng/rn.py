# This file was automatically generated by SWIG (https://www.swig.org).
# Version 4.1.1
#
# Do not make changes to this file unless you know what you are doing - modify
# the SWIG interface file instead.

from sys import version_info as _swig_python_version_info
# Import the low-level C/C++ module
if __package__ or "." in __name__:
    from . import _rn
else:
    import _rn

try:
    import builtins as __builtin__
except ImportError:
    import __builtin__

def _swig_repr(self):
    try:
        strthis = "proxy of " + self.this.__repr__()
    except __builtin__.Exception:
        strthis = ""
    return "<%s.%s; %s >" % (self.__class__.__module__, self.__class__.__name__, strthis,)


def _swig_setattr_nondynamic_instance_variable(set):
    def set_instance_attr(self, name, value):
        if name == "this":
            set(self, name, value)
        elif name == "thisown":
            self.this.own(value)
        elif hasattr(self, name) and isinstance(getattr(type(self), name), property):
            set(self, name, value)
        else:
            raise AttributeError("You cannot add instance attributes to %s" % self)
    return set_instance_attr


def _swig_setattr_nondynamic_class_variable(set):
    def set_class_attr(cls, name, value):
        if hasattr(cls, name) and not isinstance(getattr(cls, name), property):
            set(cls, name, value)
        else:
            raise AttributeError("You cannot add class attributes to %s" % cls)
    return set_class_attr


def _swig_add_metaclass(metaclass):
    """Class decorator for adding a metaclass to a SWIG wrapped class - a slimmed down version of six.add_metaclass"""
    def wrapper(cls):
        return metaclass(cls.__name__, cls.__bases__, cls.__dict__.copy())
    return wrapper


class _SwigNonDynamicMeta(type):
    """Meta class to enforce nondynamic attributes (no new attributes) for a class"""
    __setattr__ = _swig_setattr_nondynamic_class_variable(type.__setattr__)



def log_sum_exp(v):
    return _rn.log_sum_exp(v)
class rn(object):
    thisown = property(lambda x: x.this.own(), lambda x, v: x.this.own(v), doc="The membership flag")

    def __init__(self, *args, **kwargs):
        raise AttributeError("No constructor defined - class is abstract")
    __repr__ = _swig_repr

    def normal(self):
        return _rn.rn_normal(self)

    def uniform(self):
        return _rn.rn_uniform(self)

    def chi_square(self, df):
        return _rn.rn_chi_square(self, df)

    def exp(self):
        return _rn.rn_exp(self)

    def log_gamma(self, shape):
        return _rn.rn_log_gamma(self, shape)

    def gamma(self, shape, rate):
        return _rn.rn_gamma(self, shape, rate)

    def beta(self, a, b):
        return _rn.rn_beta(self, a, b)

    def discrete(self):
        return _rn.rn_discrete(self)

    def geometric(self, p):
        return _rn.rn_geometric(self, p)

    def set_wts(self, _wts):
        return _rn.rn_set_wts(self, _wts)

    def log_dirichlet(self, alpha):
        return _rn.rn_log_dirichlet(self, alpha)
    __swig_destroy__ = _rn.delete_rn

# Register rn in _rn:
_rn.rn_swigregister(rn)
class arn(rn):
    thisown = property(lambda x: x.this.own(), lambda x, v: x.this.own(v), doc="The membership flag")
    __repr__ = _swig_repr

    def __init__(self, *args):
        _rn.arn_swiginit(self, _rn.new_arn(*args))
    __swig_destroy__ = _rn.delete_arn

    def normal(self):
        return _rn.arn_normal(self)

    def uniform(self):
        return _rn.arn_uniform(self)

    def chi_square(self, df):
        return _rn.arn_chi_square(self, df)

    def exp(self):
        return _rn.arn_exp(self)

    def log_gamma(self, shape):
        return _rn.arn_log_gamma(self, shape)

    def gamma(self, shape, rate):
        return _rn.arn_gamma(self, shape, rate)

    def beta(self, a, b):
        return _rn.arn_beta(self, a, b)

    def discrete(self):
        return _rn.arn_discrete(self)

    def geometric(self, p):
        return _rn.arn_geometric(self, p)

    def set_wts(self, _wts):
        return _rn.arn_set_wts(self, _wts)

    def set_seed(self, n1, n2):
        return _rn.arn_set_seed(self, n1, n2)

    def get_seed(self, n1, n2):
        return _rn.arn_get_seed(self, n1, n2)

    def log_dirichlet(self, alpha):
        return _rn.arn_log_dirichlet(self, alpha)

# Register arn in _rn:
_rn.arn_swigregister(arn)
